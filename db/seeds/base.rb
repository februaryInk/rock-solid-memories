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
      end
    end
  end
end

def self.product_variants_with_option_values( option_value_ids, product_id )
  Spree::Variant.joins( :option_value_variants ).where( :product_id => product_id ).where( ( [ 'spree_variants.id IN ( SELECT variant_id FROM spree_option_value_variants WHERE option_value_id = ? )' ] * option_value_ids.count ).join( ' AND ' ), *option_value_ids )
end

puts 'Creating Option Types...'

option_types = [
  {
    :name => 'rock-font',
    :presentation => 'Font'
  },
  {
    :name => 'rock-image',
    :presentation => 'Image?'
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

font_names = [
  'Arial',
  'Georgia',
  'Tahoma'
]

option_values = [  ]

font_names.each_with_index do | font_name, i |
  option_values << {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-font' ).id,
    :name => font_name,
    :position => i + 1,
    :presentation => font_name
  }
end

option_values = option_values.concat( [
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-image' ).id,
    :name => 'True',
    :position => 1,
    :presentation => 'Yes'
  },
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-image' ).id,
    :name => 'False',
    :position => 2,
    :presentation => 'No'
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
] )

rock_option_values = [  ]

option_values.each do | option_value |
  rock_option_values << Spree::OptionValue.find_or_initialize_by( :name => option_value[ :name ] ).tap do | o |
    o.assign_attributes( option_value )
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

ap option_value_ids_by_type

rock_products.each do | product |
  match_ids( option_value_ids_by_type, 0, [  ], product )
end
