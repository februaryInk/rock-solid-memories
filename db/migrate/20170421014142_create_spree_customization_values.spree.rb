# This migration comes from spree (originally 20170419213343)
class CreateSpreeCustomizationValues < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_customization_values do |t|
      
      t.references :customization, index: true
      
      t.integer :position
      
      t.string :name
      t.string :presentation

      t.timestamps
    end
    
    add_foreign_key :spree_customization_values, :spree_customizations, column: :customization_id
  end
end
