class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.references :address
      t.references :customer
      t.string :stage
      t.integer :source
      t.text :damage
      t.integer :status
      t.date :roof_built_at
      t.string :insurance_company
      t.string :claim_number
      t.string :mortgage_company
      t.string :loan_tracking_number

      t.timestamps
    end

    add_index :sites, :stage
  end
end
