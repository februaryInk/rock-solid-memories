puts 'Creating Option Types...'

option_types = [
  {
    :name => 'rock-size',
    :presentation => 'Size'
  }
]

rock_option_types = [  ]

option_types.each do | option_type |
  rock_option_types << Spree::OptionType.find_or_initialize_by( :name => option_type[ :name ] ).tap do | o |
    if ( $write && o.new_record? ) || ( $overwrite && !o.new_record? )
      o.assign_attributes( option_type )
      write_or_overwrite( o )
    end
  end
end

puts 'Creating Option Values...'

option_values = [
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id,
    :name => 'small',
    :position => 1,
    :presentation => 'Small (4"-6")'
  },
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id,
    :name => 'medium',
    :position => 2,
    :presentation => 'Medium (6"-9")'
  },
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id,
    :name => 'large',
    :position => 3,
    :presentation => 'Large (9"-12")'
  },
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id,
    :name => 'extra-large',
    :position => 4,
    :presentation => 'Extra Large (12"-16")'
  }
]

rock_option_values = [  ]

option_values.each do | option_value |
  rock_option_values << Spree::OptionValue.find_or_initialize_by( :name => option_value[ :name ] ).tap do | o |
    if ( $write && o.new_record? ) || ( $overwrite && !o.new_record? )
      o.assign_attributes( option_value )
      write_or_overwrite( o )
    end
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
    if ( $write && o.new_record? ) || ( $overwrite && !o.new_record? )
      o.assign_attributes( customization )
      write_or_overwrite( o )
    end
  end
end

puts 'Creating CustomizatonValues...'

font_names = [
  'Brush',
  'Handwriting',
  'Modern',
  'Typewriter'
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
    if ( $write && o.new_record? ) || ( $overwrite && !o.new_record? )
      o.assign_attributes( customization_value )
      write_or_overwrite( o )
    end
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
    if ( $write && o.new_record? ) || ( $overwrite && !o.new_record? )
      o.assign_attributes( prototype )
      write_or_overwrite( o )
    end
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
    :name => 'Special Occasion Keepsake',
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
    if ( $write && o.new_record? ) || ( $overwrite && !o.new_record? )
      o.assign_attributes( product )
      write_or_overwrite( o )
    end
  end
end

puts 'Creating OptionTypeProducts...'

rock_products.each do | product |
  rock_option_types.each_with_index do | option_type, i |
    Spree::ProductOptionType.find_or_initialize_by( :option_type_id => option_type.id, :product_id => product.id ).tap do | o |
      if ( $write && o.new_record? ) || ( $overwrite && !o.new_record? )
        o.assign_attributes(
          {
    	      :option_type_id => option_type.id,
    		    :position => i,
    		    :product_id => product.id,
          }
        )
        write_or_overwrite( o )
      end
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
  if variant.is_master?
    customizations = Spree::Customization.all
  else
    size = variant.option_values.find_by( :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id ).name

    customizations_for_size = {
      'small' => [
        'font',
        'text-line-1',
        'text-line-2',
        'notes'
      ],
      'medium' => [
        'font',
        'text-line-1',
        'text-line-2',
        'text-line-3',
        'notes'
      ],
      'large' => [
        'font',
        'text-line-1',
        'text-line-2',
        'text-line-3',
        'text-line-4',
        'notes'
      ],
      'extra-large' => [
        'font',
        'text-line-1',
        'text-line-2',
        'text-line-3',
        'text-line-4',
        'notes'
      ]
    }

    ap customizations_for_size[ size ]
    customizations = Spree::Customization.where( :name => customizations_for_size[ size ] )
  end

  i = 1

  customizations.each do | customization |
    Spree::CustomizationVariant.find_or_initialize_by( :customization_id => customization.id, :variant_id => variant.id ).update_attributes( :position => i )
    i = i + 1
  end
end
