# This migration comes from spree (originally 20170605223043)
class CreateSpreeArtworkLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_artwork_line_items do |t|
      
      t.references :artwork, index: true
      t.references :line_item, index: true
      
      t.integer :number_of_uses, default: 1
      
      t.timestamps
    end
    
    add_foreign_key :spree_artwork_line_items, :spree_artworks, column: :artwork_id
    add_foreign_key :spree_artwork_line_items, :spree_line_items, column: :line_item_id
  end
end
