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
    :presentation => 'Medium (7"-9")'
  },
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id,
    :name => 'large',
    :position => 3,
    :presentation => 'Large (10"-12")'
  },
  {
    :option_type_id => Spree::OptionType.find_by( :name => 'rock-size' ).id,
    :name => 'extra-large',
    :position => 4,
    :presentation => 'Extra Large (13"-15")'
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
    :description => 'An engraved stone makes an enduring tribute to an individual’s accomplishments and character. Perfect for Teacher Appreciation, competitions, service awards, or any occasion where you want to tell someone that they are admired for their efforts.',
    :name => 'Awards and Honors',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'Cut stone makes for an excellent indoor or outdoor display. It can be set upright like a plaque for tabletop display (may require a support), or laid flat as a stepping stone. Our cut stone is relatively uniform in thickness, being 1” to 3” in depth.',
    :name => 'Cut Stone',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'Though the design you have in mind does not fit neatly into any of our specific categories, we will still be happy to make it for you. Just let us know what you want, whatever it may be. If you are looking for unusual custom work that we don’t offer through our online order forms, such as on-site engraving or an extra large rock, we can do that too - just contact us and we can work with you on the details.',
    :name => 'Engraved Stone (General)',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'Set the tone in your garden (flower or otherwise) with a garden stone. These keepsakes are a great way to display a favorite quote, artwork, or words to live by.',
    :name => 'Garden Stone',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'If you are looking to honor the memory of a loved one or to commemorate someone in your life, there are few methods that are as lasting as a custom engraved stone.',
    :name => 'Memorial',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'Personalized engraved stones have proven to be one of our most popular offerings. Set your name in stone to add a signature touch to your home. We have created personalized stones in several different forms, including as a means to display a family name, a monogram, or individual family members’ names.',
    :name => 'Personalized Stone',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'We know from experience how difficult it is to lose a beloved pet. A pet memorial commemorates the life of a cherished companion, no matter how big or small. We take great care in crafting these memorials with the hope that they will help to bring feelings of closure and peace during a time of grief and loss.',
    :name => 'Pet Memorial',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'Commemorate any kind of big day, from weddings and anniversaries to graduations to birthdays, with a durable engraved keepsake stone. You can truly make it a day that will be remembered for generations to come. Given the celebratory nature, this variety of engraved rock makes an excellent gift.',
    :name => 'Special Occasion Keepsake',
    :price => 35.00,
    :shipping_category_id => Spree::ShippingCategory.first.id
  },
  {
    :available_on => 1.day.ago,
    :description => 'Bid welcome to visitors of your home or business by displaying an engraved welcome stone. The style of the font and artwork can uniquely complement your building’s decor.',
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
