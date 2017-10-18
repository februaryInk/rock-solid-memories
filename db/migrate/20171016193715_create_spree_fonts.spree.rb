# This migration comes from spree (originally 20171015222426)
class CreateSpreeFonts < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_fonts do |t|

      t.string :name
      t.string :presentation

      t.timestamps
    end
  end
end
