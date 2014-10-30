class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :itemdescription
      t.float :itemprice
      t.integer :purchasecount
      t.references :merchant, index: true
      t.references :purchaser, index: true

      t.timestamps
    end
  end
end
