class CreateInspections < ActiveRecord::Migration
  def change
    create_table :inspections do |t|
      t.datetime :completed_at
      t.integer :site_id

      t.timestamps
    end

    add_index :inspections, :site_id
  end
end
