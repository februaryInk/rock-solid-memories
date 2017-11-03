# This migration comes from spree (originally 20171025192924)
class CreateSpreeFontLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_font_line_items do |t|

      t.references :font, index: true
      t.references :line_item, index: true

      t.timestamps
    end

    add_foreign_key :spree_font_line_items, :spree_fonts, column: :font_id
    add_foreign_key :spree_font_line_items, :spree_line_items, column: :line_item_id
  end
end
