# This migration comes from spree (originally 20170419210423)
class CreateSpreeCustomizationVariants < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_customization_variants do |t|
      
      t.references :customization, index: true
      t.references :variant, index: true
      
      t.integer :position
      
      t.timestamps
    end
    
    add_foreign_key :spree_customization_variants, :spree_customizations, column: :customization_id
    add_foreign_key :spree_customization_variants, :spree_variants, column: :variant_id
  end
end
