desc 'Upload any artworks in `db/seeds/seed_files/artwork.rb`.'

namespace :records do
  task :update_artworks => :environment do

    load( Rails.root.join( 'db/seeds/seed_files/artwork.rb' ) ) if File.exist?( Rails.root.join( 'db/seeds/seed_files/artwork.rb' ) )
  end
end
