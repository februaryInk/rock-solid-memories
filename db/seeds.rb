def self.load_if_exists( file_path )
  if File.exist?( file_path )
    begin
      # If there is an error that occurs during seeding, the transaction causes
      # all data seeded up to that point to be rolled back. This prevents the
      # database from being incompletely seeded.
      ActiveRecord::Base.transaction do
        load( file_path )
      end
    rescue StandardError => e
      puts 'Error: ' + e.message
      puts e.backtrace
    end
  end
end

def self.yes?( input )
  [ 'Y', 'y', 'Yes', 'yes' ].include?( input )
end

if ENV[ 'SEED_SPREE' ]
  begin
    Spree::Core::Engine.load_seed if defined?(Spree::Core)
    Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
  rescue StandardError => e
    puts 'Spree seeds were not run successfully. Perhaps they are already in the database?'
  end
end

# Initialize variables with safe settings.
$write = false
$require_write_permission = true
$overwrite = false
$require_overwrite_permission = true

puts 'Database seeding initiated.'

puts 'Do you want to seed any new records that aren\'t in the database already? (y/n)'
$write = yes?( STDIN.gets.chomp )

if $write
  puts 'If the record being seeded is new, do you want to be asked permission before it is saved to the database? (y/n)'
  $require_write_permission = yes?( STDIN.gets.chomp )
end

puts 'Do you want to overwrite any records that are in the database already? (y/n)'
$overwrite = yes?( STDIN.gets.chomp )

if $overwrite
  puts 'If the record being seeded is NOT new, do you want to be asked permission before the record currently in the database is overwritten? (y/n)'
  $require_overwrite_permission = yes?( STDIN.gets.chomp )
end

if $write || $overwrite
  # Allow separate files for test, development, and production seeds by loading
  # one file in accordance with the current environment.
  load_if_exists( Rails.root.join( 'db', 'seeds', "#{Rails.env.downcase}.rb" ) )
end
