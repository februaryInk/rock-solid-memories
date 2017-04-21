# This migration comes from spree (originally 20170419190815)
class AddCustomizationsToLineItems < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_line_items, :customizations, :text
  end
end
