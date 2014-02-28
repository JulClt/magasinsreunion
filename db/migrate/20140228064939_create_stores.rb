class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :postcode
      t.string :town
      t.string :phonenumber
      t.string :email
      t.string :name_shopper
      t.string :activity

      t.timestamps
    end
  end
end
