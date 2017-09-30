puts 'Creating Images for products...'

file_paths = Dir.glob( "#{Rails.root}/db/seeds/product_images/**/*.jpg" )

# broken method long-term. what will i do when i need to specify variants?
file_paths.each do | file_path |
  file = File.new( file_path )
  file_name = File.basename( file )

  Spree::Image.find_or_initialize_by( :attachment_file_name => file_name ).tap do | o |

    puts "Uploading #{file_name}..."

    parts = File.basename( file, File.extname( file ) ).split( '_' )
    product_slug = parts[ 1 ]
    description = parts[ 2 ].gsub( '-', ' ' ).gsub( '  ', '-' )
    product = Spree::Product.find_by( :slug => product_slug )

    if product
      o.update_attributes(
        {
          :alt => "A #{product.name} #{description}.",
          :attachment => ActionDispatch::Http::UploadedFile.new( :tempfile => file, :filename => file_name.downcase, :type => MIME::Types.type_for( file_path ).first.content_type ),
          :viewable_id => product.master.id,
          :viewable_type => 'Spree::Variant'
        }
      )
    else
      puts "No product was found with the slug #{product_slug}."
    end
  end
end
