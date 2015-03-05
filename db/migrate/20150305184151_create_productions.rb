class CreateProductions < ActiveRecord::Migration
  def change
    create_table :productions do |t|
      t.references :site
      t.date :delivery_date
      t.date :production_date
      t.date :roof_built_date
      t.date :production_inspection_date
      t.date :production_inspection_passed_date
      t.text :materials_not_used
      t.string :permit_number
      t.date :permit_date
      t.string :permit_department
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
