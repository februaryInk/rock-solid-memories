def self.match_ids( id_set, i, matched_ids, product )
  if i < id_set.length - 1
    id_set[ i ].each do | j |
      match_ids( id_set, i + 1, matched_ids + [ j ], product )
    end
  else
    id_set[ i ].each do | j |
      matched_set = matched_ids + [ j ]
      product_variants_with_option_values( matched_set, product.id ).first_or_initialize( :product_id => product.id ).tap do | o |
        o.assign_attributes(
          :option_values => Spree::OptionValue.find( matched_set ),
          :sku => ( [ product.id ] + matched_set ).join( '-' ),
          :track_inventory => false,
          :weight => 20.0
        )
        o.save
        
        Spree::Price.find_or_initialize_by( :variant_id => o.id ).tap do | p |
          p.assign_attributes(
            :amount => [
              product.master.price,
              rock_image_value_prices[ o.option_values.where( :option_type_id => Spree::OptionType.find_by( :name => 'rock-image-type' ).id ).first.name ],
              rock_size_value_prices[ o.option_values.where( :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id ).first.name ]
            ].sum,
            :currency => 'USD'
          )
          p.save
        end
      end
    end
  end
end

def self.product_variants_with_option_values( option_value_ids, product_id )
  Spree::Variant.joins( :option_value_variants ).where( :product_id => product_id ).where( ( [ 'spree_variants.id IN ( SELECT variant_id FROM spree_option_value_variants WHERE option_value_id = ? )' ] * option_value_ids.count ).join( ' AND ' ), *option_value_ids )
end

def self.rock_image_value_prices
  { 
    'Catalog' => 25.00, 
    'None' => 0.00 
  }
end

def self.rock_size_value_prices
  {
    'Small' => 0.00,
    'Medium' => 25.00,
    'Large' => 50.00,
    'Extra Large' => 75.00
  }
end

puts 'Updating Store...'

Spree::Store.first_or_initialize(  ).tap do | o |
  o.assign_attributes(
    :code => 'rsm',
    :default => true,
    :default_currency => 'USD',
    :mail_from_address => 'rocksolidmemories@gmail.com',
    :meta_description => 'A stone engraving business.',
    :meta_keywords => 'stone rock engraving menories',
    :name => 'Rock Solid Memories',
    :seo_title => 'Rock Solid Memories',
    :url => 'http://rocksolidmemories.com'
  )
  o.save
end

puts 'Creating Roles...'

Spree::Role.where( :name => 'admin' ).first_or_create
Spree::Role.where( :name => 'user' ).first_or_create

puts 'Creating Users...'

users = [
  {
    :email => 'febrink@gmail.com',
    :password => 'adminpass',
    :password_confirmation => 'adminpass'
  }
]

users.each do | user |
  Spree::User.find_or_initialize_by( :email => user[ :email ] ).tap do | o |
    o.assign_attributes( user )
    o.save
    
    Spree::RoleUser.find_or_create_by(
      :role_id => Spree::Role.find_by( :name => 'admin' ).id,
      :user_id => o.id
    )
  end
end

puts 'Creating ShippingCategories...'

shipping_categories = [
  {
    :name => 'Rock'
  }
]

shipping_categories.each do | shipping_category |
  Spree::ShippingCategory.find_or_initialize_by( :name => shipping_category[ :name ] ).tap do | o |
    o.assign_attributes( shipping_category )
    o.save
  end
end

puts 'Creating ShippingMethods...'

shipping_methods = [
  {
    :admin_name => 'FedEx Ground',
    :calculator_type => 'Spree::Calculator::Shipping::FlatPercentItemTotal',
    :code => 'fg',
    :display_on => '',
    :name => 'FedEx Ground',
    :shipping_categories => [ Spree::ShippingCategory.find_by( :name => 'Rock' ) ],
    :tax_category_id => nil,
    :tracking_url => 'https://www.fedex.com/apps/fedextrack/',
  }
]

shipping_methods.each do | shipping_method |
  Spree::ShippingMethod.find_or_initialize_by( :admin_name => shipping_method[ :admin_name ] ).tap do | o |
    o.assign_attributes( shipping_method )
    o.valid?
    ap o.errors.messages
    o.save
    
    o.calculator.update_attributes(
      :preferences => {
        :flat_percent => 20.0
      }
    )
  end
end

puts 'Creating Countries...'

countries = [
  {
    :iso => 'US',
    :iso3 => 'USA',
    :iso_name => 'UNITED STATES',
    :name => 'United States',
    :numcode => '581',
    :states_required => true,
    :zipcode_required => true
  }
]

countries.each do | country |
  Spree::Country.find_or_initialize_by( :name => country[ :name ] ).tap do | o |
    o.assign_attributes( country )
    o.save
  end
end

puts 'Creating States...'

connection = ApplicationRecord.connection
state_inserts = []

state_values = -> do
  Spree::Country.where(states_required: true).each do |country|
    carmen_country = Carmen::Country.named(country.name)
    carmen_country.subregions.each do |subregion|
      name       = connection.quote subregion.name
      abbr       = connection.quote subregion.code
      country_id = connection.quote country.id

      state_inserts << [name, abbr, country_id].join(", ")
    end
  end

  state_inserts.map { |x| "(#{x})" }
end

columns = ["name", "abbr", "country_id"].map do |column|
  connection.quote_column_name column
end.join(', ')

state_values.call.each_slice(500) do |state_values_batch|
  connection.execute <<-SQL
    INSERT INTO spree_states (#{columns})
    VALUES #{state_values_batch.join(", ")};
  SQL
end

puts 'Creating Zones...'

zones = [
  {
    :default_tax => false,
    :description => '',
    :kind => 'country',
    :name => 'Continental United States',
    :zone_members_count => 1
  }
]

zones.each do | zone |
  Spree::Zone.find_or_initialize_by( :name => zone[ :name ] ).tap do | o |
    o.assign_attributes( zone )
    o.save
  end
end

Spree::Zone.all.each do | o |
  Spree::ZoneMember.find_or_create_by(
    :zone_id => o.id,
    :zoneable => Spree::Country.find_by( :name => 'United States' )
  )
  
  Spree::ShippingMethodZone.find_or_create_by(
    :shipping_method_id => Spree::ShippingMethod.find_by( :admin_name => 'FedEx Ground' ).id,
    :zone_id => o.id
  )
end

puts 'Creating StockLocations...'

stock_locations = [
  {
    :active => true,
    :address1 => '17671 48th Avenue',
    :address2 => '',
    :admin_name => 'Home',
    :backorderable_default => true,
    :city => 'Coopersville',
    :country_id => Spree::Country.find_by( :name => 'United States' ).id,
    :default => true,
    :name => 'Rock Solid Memories',
    :phone => '(616) 837-5062',
    :propagate_all_variants => true,
    :state_id => Spree::State.find_by( :name => 'Michigan' ).id,
    :state_name => 'Michigan',
    :zipcode => '49404'
  }
]

stock_locations.each do | stock_location |
  Spree::StockLocation.find_or_initialize_by( :name => stock_location[ :name ] ).tap do | o |
    o.assign_attributes( stock_location )
    o.save
  end
end

puts 'Creating PaymentMethods...'

payment_methods = [
  {
    :active => true,
    :auto_capture => true,
    :description => '',
    :display_on => 'both',
    :name => 'PayPal Gateway',
    :position => 1,
    :preferences => {
      :currency_code => 'USD',
      :login => 'rocksolidmemories-facilitator_api1.gmail.com',
      :password => '6US53UHAQ5LK2DRC',
      :server => 'test',
      :signature => 'AFcWxV21C7fd0v3bYYYRCpSSRl31A9NTW9-E7VVBhskkVVnQ24vKXGaJ',
      :test_mode => true
    },
    :type => 'Spree::Gateway::PayPalGateway'
  }
]

payment_methods.each do | payment_method |
  Spree::PaymentMethod.find_or_initialize_by( :name => payment_method[ :name ] ).tap do | o |
    o.assign_attributes( payment_method )
    o.save
  end
end

puts 'Creating Option Types...'

option_types = [
  {
    :name => 'rock-image-type',
    :presentation => 'Image Type'
  },
  {
    :name => 'rock-size',
    :presentation => 'Size'
  }
]

rock_option_types = [  ]

option_types.each do | option_type |
  rock_option_types << Spree::OptionType.find_or_initialize_by( :name => option_type[ :name ] ).tap do | o |
    o.assign_attributes( option_type )
    o.save
  end
end

puts 'Creating Option Values...'

option_values = [
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-image-type' ).id,
    :name => 'None',
    :position => 1,
    :presentation => 'None'
  },
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-image-type' ).id,
    :name => 'Catalog',
    :position => 2,
    :presentation => 'Catalog'
  },
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id,
    :name => 'Small',
    :position => 1,
    :presentation => 'Small (4"-6")'
  },
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id,
    :name => 'Medium',
    :position => 2,
    :presentation => 'Medium (6"-9")'
  },
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id,
    :name => 'Large',
    :position => 3,
    :presentation => 'Large (9"-12")'
  },
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id,
    :name => 'Extra Large',
    :position => 4,
    :presentation => 'Extra Large (12"-16")'
  }
]

rock_option_values = [  ]

option_values.each do | option_value |
  rock_option_values << Spree::OptionValue.find_or_initialize_by( :name => option_value[ :name ] ).tap do | o |
    o.assign_attributes( option_value )
    o.save
  end
end

puts 'Creating Customizations...'

customizations = [
  {
    :name => 'font',
    :presentation => 'Font',
    :value_type => 'select'
  },
  {
    :name => 'catalog-artwork',
    :presentation => 'Image Catalog Code',
    :value_type => 'string'
  },
  {
    :name => 'text-line-1',
    :presentation => 'Text Line 1',
    :value_type => 'string'
  },
  {
    :name => 'text-line-2',
    :presentation => 'Text Line 2',
    :value_type => 'string'
  },
  {
    :name => 'text-line-3',
    :presentation => 'Text Line 3',
    :value_type => 'string'
  },
  {
    :name => 'text-line-4',
    :presentation => 'Text Line 4',
    :value_type => 'string'
  },
  {
    :name => 'notes',
    :presentation => 'Additional Notes',
    :value_type => 'text'
  }
]

customizations.each do |customization|
  Spree::Customization.find_or_initialize_by( :name => customization[ :name ] ).tap do | o |
    o.assign_attributes( customization )
    o.save
  end
end

puts 'Creating CustomizatonValues...'

font_names = [
  'Arial',
  'Georgia',
  'Tahoma'
]

customization_values = [  ]

font_names.each_with_index do | font_name, i |
  customization_values << {
    :customization_id => Spree::Customization.find_by( :name => 'font' ).id,
    :name => font_name,
    :position => i + 1,
    :presentation => font_name
  }
end

customization_values.each do | customization_value |
  Spree::CustomizationValue.find_or_initialize_by( :name => customization_value[ :name ] ).tap do | o |
    o.assign_attributes( customization_value )
    o.save
  end
end

puts 'Creating Prototypes...'

prototypes = [
  {
    :name => 'Engraved Stone',
  }
]

prototypes.each do | prototype |
  Spree::Prototype.find_or_initialize_by( :name => prototype[ :name ] ).tap do | o |
    o.assign_attributes( prototype )
    o.save
  end
end

puts 'Creating Products...'

products = [
  {
    :available_on => 1.day.ago,
    :description => 'A gift for someone you appreciate.',
    :name => 'Awards and Honors',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'If none of our specific engraved stond categories suite your needs, use this general category.',
    :name => 'Engraved Stone (General)',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'Set the mood for your garden or landscaping.',
    :name => 'Garden Stone',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'In rememberance.',
    :name => 'Memorial',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'Display your family\'s name.',
    :name => 'Personalized Stone',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'In rememberance of a beloved pet.',
    :name => 'Pet Memorial',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'For big events like weddings, anniversaries, and birthdays.',
    :name => 'Special Ocassion Keepsake',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'A flat paving stone for walkways.',
    :name => 'Stepping Stone',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'Greet your guests.',
    :name => 'Welcome Sign',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  }
]

rock_products = [  ]

products.each do | product |
  rock_products << Spree::Product.find_or_initialize_by( :name => product[ :name ] ).tap do | o |
    o.assign_attributes( product )
    o.save
  end
end

puts 'Creating OptionTypeProducts...'

rock_products.each do | product |
  rock_option_types.each_with_index do | option_type, i |
    Spree::ProductOptionType.find_or_initialize_by( :option_type_id => option_type.id, :product_id => product.id ).tap do | o |
      o.assign_attributes(
        {
	      :option_type_id => option_type.id,
		  :position => i,
		  :product_id => product.id,
        }
      )
      o.save
    end
  end
end

puts 'Creating Variants and OptionValueVariants...'

option_value_ids_by_type = [  ]

rock_option_types.each do | option_type |
  option_value_ids_by_type << option_type.option_values.pluck( :id )
end

rock_products.each do | product |
  match_ids( option_value_ids_by_type, 0, [  ], product )
end

puts 'Creating CustomizationVariants...'

Spree::Variant.all.each do | variant |
  next if variant.option_value_variants.empty?
  
  size = variant.option_values
    .find_by( :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id ).name
  image = variant.option_values
    .find_by( :option_type_id => Spree::OptionType.find_by( :name => 'rock-image-type' ).id ).name
  i = 1
    
  Spree::CustomizationVariant.find_or_initialize_by( :customization_id => Spree::Customization.find_by( :name => 'font' ).id, :variant_id => variant.id ).update_attributes( :position => i )
  i = i + 1
  
  Spree::CustomizationVariant.find_or_initialize_by( :customization_id => Spree::Customization.find_by( :name => 'text-line-1' ).id, :variant_id => variant.id ).update_attributes( :position => i )
  i = i + 1
  
  if image == 'None'
    Spree::CustomizationVariant.find_or_initialize_by( :customization_id => Spree::Customization.find_by( :name => 'text-line-2' ).id, :variant_id => variant.id ).update_attributes( :position => i )
    i = i + 1
  
    if [ 'Medium', 'Large', 'Extra Large' ].include?( size )
      Spree::CustomizationVariant.find_or_initialize_by( :customization_id => Spree::Customization.find_by( :name => 'text-line-3' ).id, :variant_id => variant.id ).update_attributes( :position => i )
      i = i + 1
    end

    if [ 'Large', 'Extra Large' ].include?( size )
      Spree::CustomizationVariant.find_or_initialize_by( :customization_id => Spree::Customization.find_by( :name => 'text-line-4' ).id, :variant_id => variant.id ).update_attributes( :position => i )
      i = i + 1
    end
  else
    if [ 'Medium', 'Large', 'Extra Large' ].include?( size )
      Spree::CustomizationVariant.find_or_initialize_by( :customization_id => Spree::Customization.find_by( :name => 'text-line-2' ).id, :variant_id => variant.id ).update_attributes( :position => i )
      i = i + 1
    end

    if [ 'Large', 'Extra Large' ].include?( size )
      Spree::CustomizationVariant.find_or_initialize_by( :customization_id => Spree::Customization.find_by( :name => 'text-line-3' ).id, :variant_id => variant.id ).update_attributes( :position => i )
      i = i + 1
    end
    
    Spree::CustomizationVariant.find_or_initialize_by( :customization_id => Spree::Customization.find_by( :name => 'catalog-artwork' ).id, :variant_id => variant.id ).update_attributes( :position => i )
      i = i + 1
  end 
  
  Spree::CustomizationVariant.find_or_initialize_by( :customization_id => Spree::Customization.find_by( :name => 'notes' ).id, :variant_id => variant.id ).update_attributes( :position => i )
end
