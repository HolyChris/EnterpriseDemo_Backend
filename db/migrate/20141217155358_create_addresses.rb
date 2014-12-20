class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string     :address1
      t.string     :address2
      t.string     :city
      t.string     :zipcode
      t.string     :phone
      t.string     :state_name
      t.string     :alt_phone
      t.string     :company
      t.references :state
      t.references :country
      t.references :customer

      t.timestamps
    end
  end
end
