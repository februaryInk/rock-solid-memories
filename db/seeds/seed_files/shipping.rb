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
        :flat_percent => 25.0
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
