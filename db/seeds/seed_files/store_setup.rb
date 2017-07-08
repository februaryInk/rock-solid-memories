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
