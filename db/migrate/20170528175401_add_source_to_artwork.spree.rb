# This migration comes from spree (originally 20170528153900)
class AddSourceToArtwork < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_artworks, :source, :string
  end
end
