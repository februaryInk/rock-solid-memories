puts 'Creating Collections...'

collections = [
  {
    :name => 'Animals',
    :description => '' 
  },
  {
    :name => 'Decorations and Flourishes',
    :description => '' 
  },
  {
    :name => 'Flora',
    :description => '' 
  },
  {
    :name => 'Oceans, Lakes, and Rivers',
    :description => '' 
  },
  {
    :name => 'Pets',
    :description => '' 
  },
  {
    :name => 'Stylized Words and Letters',
    :description => '' 
  },
  {
    :name => 'Travel',
    :description => '' 
  },
  {
    :name => 'Wilderness',
    :description => '' 
  },
  {
    :name => 'Wildlife',
    :description => '' 
  }
]

collections.each do |collection|
  Spree::Collection.find_or_initialize_by( :name => collection[ :name ] ).tap do |o|
    o.assign_attributes( collection )
    o.save
  end
end

puts 'Creating Artworks...'

artworks = [
  {
    :code => 'ANCHOR1',
    :collection_ids => Spree::Collection.where( :name => [ 'Oceans, Lakes, and Rivers' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'An old-fashioned boat anchor tied with a rope',
    :source => 'Wildlife pack'
  },
  {
    :code => 'ARROW1',
    :collection_ids => Spree::Collection.where( :name => [ 'Decorations and Flourishes' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A decorative arrow with a heart-shaped head.',
    :source => 'The Noun Project'
  }
]

artworks.each do |artwork|
  Spree::Artwork.find_or_initialize_by( :code => artwork[ :code ] ).tap do |o|
    begin
      file_path = "#{Rails.root}/db/seeds/galleries/artworks/#{artwork[ :code ]}.jpg"
      file = File.new( file_path )
      
      artwork.merge!( 
        { 
          :image_attributes => {
            :attachment => ActionDispatch::Http::UploadedFile.new( :tempfile => file, :filename => File.basename( file ), :type => MIME::Types.type_for( file_path ).first.content_type )
          }
        }
      )
      
      puts artwork
      
      o.assign_attributes( artwork )
      o.save
    rescue StandardError => e
      puts e
    end
  end
end
