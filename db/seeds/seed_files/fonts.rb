puts 'Creating Fonts...'

fonts = [
  {
    :name => 'Aleo Bold',
    :presentation => 'Aleo Bold'
  },
  {
    :name => 'Arima Koshi',
    :presentation => 'Arima Koshi'
  },
  {
    :name => 'Berkshire Swash',
    :presentation => 'Berkshire Swash'
  },
  {
    :name => 'Bookman Old Style Bold',
    :presentation => 'Bookman Old Style Bold'
  },
  {
    :name => 'Copperplate Gothic Bold',
    :presentation => 'Copperplate Gothic Bold'
  },
  {
    :name => 'Germania One',
    :presentation => 'Germania Old'
  },
  {
    :name => 'Infini Bold',
    :presentation => 'Infini Bold'
  },
  {
    :name => 'Montserrat Alternates Semi',
    :presentation => 'Montserrat Alternates Semi'
  },
  {
    :name => 'Mothproof Script',
    :presentation => 'Mothproof Script'
  },
  {
    :name => 'Nautilus Pompilius',
    :presentation => 'Nautilus Pompilius'
  },
  {
    :name => 'Script MT Bold',
    :presentation => 'Script MT Bold'
  }
]

fonts.each do |font|
  Spree::Font.find_or_initialize_by( :name => font[ :name ] ).tap do | o |
    begin
      preview_file_path = "#{Rails.root}/db/seeds/images/fonts/#{font[ :name ].downcase.gsub( ' ', '-' )}-preview.jpg"
      preview_file = File.new( preview_file_path )

      font.merge!(
        {
          :preview_image_attributes => {
            :attachment => ActionDispatch::Http::UploadedFile.new( :tempfile => preview_file, :filename => File.basename( preview_file ), :type => MIME::Types.type_for( preview_file_path ).first.content_type ),
            :position => 1
          }
        }
      )

      file_path = "#{Rails.root}/db/seeds/images/fonts/#{font[ :name ].downcase.gsub( ' ', '-' )}.jpg"
      file = File.new( file_path )

      font.merge!(
        {
          :image_attributes => {
            :attachment => ActionDispatch::Http::UploadedFile.new( :tempfile => file, :filename => File.basename( file ), :type => MIME::Types.type_for( file_path ).first.content_type ),
            :position => 2
          }
        }
      )

      o.assign_attributes( font )
      o.save

      # make sure the image positions are corrent. acts_as_list is doing
      # something unwanted.
      o.images.find_by( attachment_file_name: File.basename( preview_file ) ).update_column( :position, 1 )
      o.images.find_by( attachment_file_name: File.basename( file ) ).update_column( :position, 2 )
    rescue StandardError => e
      puts e
    end
  end
end
