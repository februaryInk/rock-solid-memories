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
          :sku => ( [ product.id ] + matched_set ).join( '-' )
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
    :presentation => 'Small'
  },
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id,
    :name => 'Medium',
    :position => 2,
    :presentation => 'Medium'
  },
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id,
    :name => 'Large',
    :position => 3,
    :presentation => 'Large'
  },
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id,
    :name => 'Extra Large',
    :position => 4,
    :presentation => 'Extra Large'
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

types = [
  'Engraved Stone (General)',
  'Address Marker',
  'Business Sign',
  'Event Keepsake',
  'Family Stone',
  'Garden Stone',
  'In Memory Of',
  'Pet Memorial',
  'Welcome Stone'
]

products = [
  {
    :available_on => 1.day.ago,
    :description => 'If none of our specific engraved stond categories suite your needs, use this general category to order what you need.',
    :name => 'Engraved Stone (General)',
    :price => 45.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'Display your home\'s address.',
    :name => 'Address Marker',
    :price => 45.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'In rememberance of a beloved pet.',
    :name => 'Pet Memorial',
    :price => 45.00,
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
