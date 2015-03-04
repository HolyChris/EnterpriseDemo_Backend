class CreateFollowUps < ActiveRecord::Migration
  def change
    create_table :follow_ups do |t|
      t.references :appointment
      t.datetime :scheduled_at
      t.text :notes

      t.timestamps
    end
  end
end
