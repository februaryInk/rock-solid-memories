desc 'Upload any product images in `db/seeds/images/products`.'

namespace :records do
  task :upload_product_images => :environment do

    load( Rails.root.join( 'db/seeds/seed_files/product_images.rb' ) ) if File.exist?( Rails.root.join( 'db/seeds/seed_files/product_images.rb' ) )
  end
end
