class AddInsuranceAdjustors < ActiveRecord::Migration
  def change
    create_table :insurance_adjustors do |t|
      t.integer :site_id
      t.string :name
      t.string :email
      t.string :telephone
      t.string :page_token
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
