desc 'Upload any fonts in `db/seeds/seed_files/fonts.rb`.'

namespace :records do
  task :update_fonts => :environment do

    load( Rails.root.join( 'db/seeds/seed_files/fonts.rb' ) ) if File.exist?( Rails.root.join( 'db/seeds/seed_files/fonts.rb' ) )
  end
end
