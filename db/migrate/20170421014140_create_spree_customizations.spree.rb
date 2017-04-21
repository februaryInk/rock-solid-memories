# This migration comes from spree (originally 20170419205514)
class CreateSpreeCustomizations < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_customizations do |t|
      
      t.string :name
      t.string :presentation
      t.string :value_type

      t.timestamps
    end
  end
end
