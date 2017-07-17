load_if_exists( Rails.root.join( 'db', 'seeds', 'seed_files', 'functions.rb' ) )

Dir.glob( Rails.root.join( 'db', 'seeds', 'seed_files', '*.rb' ) ).each do | file |
  unless file.split( '/' )[ -1 ] == 'functions.rb'
    puts "Found seed file: #{file.split( '/' )[ -1 ]}. Would you like to load this file? (y/n)"
    load_file = yes?( STDIN.gets.chomp )

    if load_file
      load_if_exists( file )
    end
  end
end
