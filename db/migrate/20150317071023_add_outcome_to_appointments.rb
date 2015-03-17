class AddOutcomeToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :outcome, :integer
    add_index :appointments, :outcome
  end
end
