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
  },
  {
    :code => 'BEAR1',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Wildlife' ] ).pluck( :id ),
    :complexity => 5,
    :description => 'The profile of a bear that transitions into a mountainous landscape.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'BEAR2',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Wildlife' ] ).pluck( :id ),
    :complexity => 5,
    :description => 'The visage of a large bear that transitions into a mountainous landscape.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'BIRD1',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Wildlife' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'Two birds sitting on a tree branch.',
    :source => 'Farrah Brink'
  },
  {
    :code => 'BOAT1',
    :collection_ids => Spree::Collection.where( :name => [ 'Oceans, Lakes, and Rivers', 'Travel' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A ship with sails bedecked with flags and pennants.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'BORDER1',
    :collection_ids => Spree::Collection.where( :name => [ 'Decorations and Flourishes' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A straight-line border with points and flourishes at both ends.',
    :source => 'The Noun Project'
  },
  {
    :code => 'CAT1',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A simple silhouette of a sitting cat.',
    :source => 'The Noun Project'
  },
  {
    :code => 'CATPAW1',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'Two cat paw prints, side-by-side.',
    :source => 'The Noun Project'
  },
  {
    :code => 'CATPAW2',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A cat paw print with angel wings.',
    :source => 'The Noun Project, modified by Farrah Brink'
  },
  {
    :code => 'COMPASS1',
    :collection_ids => Spree::Collection.where( :name => [ 'Travel' ] ).pluck( :id ),
    :complexity => 4,
    :description => 'An ornate compass rose like those seen on maps.',
    :source => 'Wildlife map'
  },
  {
    :code => 'CROSS1',
    :collection_ids => Spree::Collection.where( :name => [ '' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'An ornate cross with Celtic knot designs.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'DEER1',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Wildlife' ] ).pluck( :id ),
    :complexity => 5,
    :description => 'The profile of a deer that transitions into a mountainous landscape.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'DEER2',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Wildlife' ] ).pluck( :id ),
    :complexity => 4,
    :description => 'An eight-point buck that is facing the viewer.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'DEER3',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Wildlife' ] ).pluck( :id ),
    :complexity => 4,
    :description => 'The head and shoulders of a large buck.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'DOG1',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets', 'Wildlife' ] ).pluck( :id ),
    :complexity => 5,
    :description => 'The head and shoulders of a black lab, wreathed by cattails. Two ducks are flying overhead.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'DOG2',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets' ] ).pluck( :id ),
    :complexity => 4,
    :description => 'The head and shoulders of a black lab, wreathed by cattails.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'DOG3',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'The head and shoulders of a black lab.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'DOG4',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets' ] ).pluck( :id ),
    :complexity => 4,
    :description => 'The head and shoulders of a yellow lab, wreathed by reeds.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'DOG5',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'The head and shoulders of a yellow lab.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'DUCK1',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets', 'Wildlife' ] ).pluck( :id ),
    :complexity => 4,
    :description => 'A duck with its wings upraised floating among cattails.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'DUCK2',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets', 'Wildlife' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A duck with its wings upraised floating in the water.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'DUCK3',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Wildlife' ] ).pluck( :id ),
    :complexity => 4,
    :description => 'A pair of wild ducks in flight.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'ELK1',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Wildlife' ] ).pluck( :id ),
    :complexity => 5,
    :description => 'A bull elk standing in profile against a mountainous scene.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'FISH1',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Oceans, Lakes, and Rivers', 'Wildlife' ] ).pluck( :id ),
    :complexity => 5,
    :description => 'A bass in profile.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'FISH2',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Oceans, Lakes, and Rivers', 'Wildlife' ] ).pluck( :id ),
    :complexity => 5,
    :description => 'A trout in profile.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'FLOURISH1',
    :collection_ids => Spree::Collection.where( :name => [ 'Decorations and Flourishes' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A bold, asymmetrical flourish.',
    :source => 'Sample art'
  },
  {
    :code => 'FLOURISH2',
    :collection_ids => Spree::Collection.where( :name => [ 'Decorations and Flourishes' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A symmetrical curling flourish.',
    :source => 'The Noun Project'
  },
  {
    :code => 'FLOURISH3',
    :collection_ids => Spree::Collection.where( :name => [ 'Decorations and Flourishes' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A symmetrical simple flourish with a small flower at the center.',
    :source => 'The Noun Project'
  },
  {
    :code => 'FLOWER1',
    :collection_ids => Spree::Collection.where( :name => [ 'Flora' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A morning glory bud on a vine.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'FLOWER2',
    :collection_ids => Spree::Collection.where( :name => [ 'Flora' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A morning glory blossom.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'FLOWER3',
    :collection_ids => Spree::Collection.where( :name => [ 'Flora' ] ).pluck( :id ),
    :complexity => 4,
    :description => 'A full morning glory vine in bloom.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'FLOWER4',
    :collection_ids => Spree::Collection.where( :name => [ 'Flora' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A morning glory blossom on a vine.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'FLOWER5',
    :collection_ids => Spree::Collection.where( :name => [ 'Flora' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A peony blossom.',
    :source => 'The Noun Project'
  },
  {
    :code => 'FLOWER6',
    :collection_ids => Spree::Collection.where( :name => [ 'Flora' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A hibiscus blossom.',
    :source => 'The Noun Project'
  },
  {
    :code => 'FLOWER7',
    :collection_ids => Spree::Collection.where( :name => [ 'Flora' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A flowering vine.',
    :source => 'The Noun Project'
  },
  {
    :code => 'FLOWER8',
    :collection_ids => Spree::Collection.where( :name => [ 'Flora' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A rose blossom.',
    :source => 'The Noun Project'
  },
  {
    :code => 'FLOWER9',
    :collection_ids => Spree::Collection.where( :name => [ 'Flora' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A lotus blossom.',
    :source => 'The Noun Project'
  },
  {
    :code => 'FLOWER10',
    :collection_ids => Spree::Collection.where( :name => [ 'Flora' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A sprig of bell flowers.',
    :source => 'The Noun Project'
  },
  {
    :code => 'FLOWER11',
    :collection_ids => Spree::Collection.where( :name => [ 'Flora' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A simple flower.',
    :source => 'The Noun Project'
  },
  {
    :code => 'FLOWER12',
    :collection_ids => Spree::Collection.where( :name => [ 'Flora' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A few strands of lavender.',
    :source => 'The Noun Project'
  },
  {
    :code => 'FOX1',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Wildlife' ] ).pluck( :id ),
    :complexity => 4,
    :description => 'A fox with its head turned to look at the viewer.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'FRAME1',
    :collection_ids => Spree::Collection.where( :name => [ 'Decorations and Flourishes' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A mountainous landscape with a frame at the bottom, good for a name or word.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'FRAME2',
    :collection_ids => Spree::Collection.where( :name => [ 'Decorations and Flourishes' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A simple geometric frame, good for initials, a number, a short word, or a picture.',
    :source => 'The Noun Project'
  },
  {
    :code => 'FRAME3',
    :collection_ids => Spree::Collection.where( :name => [ 'Decorations and Flourishes' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A wreathed shield frame, good for initials, a number, a short word, or a picture.',
    :source => 'The Noun Project'
  },
  {
    :code => 'HEART1',
    :collection_ids => Spree::Collection.where( :name => [ 'Decorations and Flourishes' ] ).pluck( :id ),
    :complexity => 1,
    :description => 'A basic heart shape.',
    :source => 'Farrah Brink'
  },
  {
    :code => 'HORSE1',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets', 'Wildlife' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'The silhouette of a running horse.',
    :source => 'Sample art'
  },
  {
    :code => 'HORSE2',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets', 'Wildlife' ] ).pluck( :id ),
    :complexity => 4,
    :description => 'A running horse with mountains in the distance.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'HORSE3',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets', 'Wildlife' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A running horse.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'HORSE4',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A cowboy riding a bucking horse.',
    :source => 'Sample art'
  },
  {
    :code => 'KISS1',
    :collection_ids => Spree::Collection.where( :name => [ '' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A smooth lipstick mark.',
    :source => 'Farrah Brink'
  },
  {
    :code => 'PLANT1',
    :collection_ids => Spree::Collection.where( :name => [ 'Flora' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A stand of cattails in shallow water.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'PRINT1',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A pair of cat paw prints.',
    :source => 'The Noun Project'
  },
  {
    :code => 'PRINT2',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets' ] ).pluck( :id ),
    :complexity => 1,
    :description => 'A dog paw print.',
    :source => 'Farrah Brink'
  },
  {
    :code => 'PRINT3',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets' ] ).pluck( :id ),
    :complexity => 1,
    :description => 'A symmetrical dog paw print.',
    :source => 'Farrah Brink'
  },
  {
    :code => 'PRINT4',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A cat paw print with wings.',
    :source => 'The Noun Project, Farrah Brink'
  },
  {
    :code => 'PRINT5',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A dog paw print with wings.',
    :source => 'Farrah Brink'
  },
  {
    :code => 'RABBIT1',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Pets', 'Wildlife' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A baby rabbit.',
    :source => 'Farrah Brink'
  },
  {
    :code => 'SHAPE1',
    :collection_ids => Spree::Collection.where( :name => [ 'Decorations and Flourishes' ] ).pluck( :id ),
    :complexity => 1,
    :description => 'A four-pointed star shape, useful for decorative word separation or bullets.',
    :source => 'Farrah Brink'
  },
  {
    :code => 'SHELL1',
    :collection_ids => Spree::Collection.where( :name => [ 'Oceans, Lakes, and Rivers', 'Travel' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A nauticulus shell.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'STARFISH1',
    :collection_ids => Spree::Collection.where( :name => [ 'Oceans, Lakes, and Rivers', 'Travel' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A traditional five-legged starfish.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'TREE1',
    :collection_ids => Spree::Collection.where( :name => [ 'Flora', 'Travel' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A bushy palm tree.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'TREE2',
    :collection_ids => Spree::Collection.where( :name => [ 'Flora' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'A large, full oak tree.',
    :source => 'The Noun Project'
  },
  {
    :code => 'VINE1',
    :collection_ids => Spree::Collection.where( :name => [ 'Decorations and Flourishes', 'Flora' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'A heart with trailing vines on either side.',
    :source => 'The Noun Project'
  },
  {
    :code => 'VINE2',
    :collection_ids => Spree::Collection.where( :name => [ 'Decorations and Flourishes', 'Flora' ] ).pluck( :id ),
    :complexity => 3,
    :description => 'An abstract curling vine.',
    :source => 'The Noun Project'
  },
  {
    :code => 'WOLF1',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Wildlife' ] ).pluck( :id ),
    :complexity => 5,
    :description => 'A wolf turning to howl at the moon in a wooded landscape. "Welcome" is inscribed below the scene.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'WOLF2',
    :collection_ids => Spree::Collection.where( :name => [ 'Animals', 'Wildlife' ] ).pluck( :id ),
    :complexity => 5,
    :description => 'A wolf howling.',
    :source => 'Wildlife pack'
  },
  {
    :code => 'WORD1',
    :collection_ids => Spree::Collection.where( :name => [ 'Stylized Words and Letters' ] ).pluck( :id ),
    :complexity => 2,
    :description => 'The word "and" stylized with curling vines.',
    :source => 'Sample art'
  },
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
      
      o.assign_attributes( artwork )
      o.save
    rescue StandardError => e
      puts e
    end
  end
end
