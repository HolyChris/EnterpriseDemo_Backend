class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :priority
      t.references :site
      t.string :insurance_carrier
      t.text :re_roof_material
      t.string :color
      t.integer :material
      t.decimal :cost, precision: 10, scale: 2
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
