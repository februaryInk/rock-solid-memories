# This migration comes from spree (originally 20170521193929)
class CreateSpreeArtworkCollections < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_artwork_collections do |t|
      
      t.references :artwork, index: true
      t.references :collection, index: true

      t.timestamps
    end
    
    add_foreign_key :spree_artwork_collections, :spree_artworks, column: :artwork_id
    add_foreign_key :spree_artwork_collections, :spree_collections, column: :collection_id
  end
end
