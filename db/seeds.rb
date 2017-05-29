if ENV[ 'SEED_SPREE' ]
  begin
    Spree::Core::Engine.load_seed if defined?(Spree::Core)
    Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
  rescue StandardError => e
    puts 'Spree seeds were not run successfully. Perhaps they are already in the database?'
  end
end

# Allow separate files for test, development, and production seeds by loading
# one file in accordance with the current environment.
if File.exist?( Rails.root.join( 'db', 'seeds', "#{Rails.env.downcase}.rb" ) )
  begin
    # If there is an error that occurs during seeding, the transaction causes
    # all data seeded up to that point to be rolled back. This prevents the 
    # database from being incompletely seeded.
    ActiveRecord::Base.transaction do
      #load( Rails.root.join( 'db', 'seeds', "#{Rails.env.downcase}.rb" ) )
      load( Rails.root.join( 'db', 'seeds', "galleries.rb" ) )
    end
  rescue StandardError => e
    puts 'Error: ' + e.message
    puts e.backtrace
  end
end
