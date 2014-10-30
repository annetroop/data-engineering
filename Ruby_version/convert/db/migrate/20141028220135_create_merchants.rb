class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :merchantname
      t.string :merchantaddress

      t.timestamps
    end
  end
end
