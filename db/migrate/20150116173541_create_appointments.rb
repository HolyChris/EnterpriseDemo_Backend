class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.date :date
      t.integer :start_time
      t.integer :end_time
      t.references :site
      t.text :notes
      t.references :user
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
