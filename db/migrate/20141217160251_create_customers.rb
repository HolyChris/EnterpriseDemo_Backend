class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :spouse
      t.string :business_name
      t.text :other_business_info
      t.integer :bill_address_id

      t.timestamps
    end

    add_index :customers, :bill_address_id
  end
end
