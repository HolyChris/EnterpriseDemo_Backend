class RemoveEndTimeAndRenameStartTimeInAppointments < ActiveRecord::Migration
  def up
    remove_column :appointments, :end_time
    add_column :appointments, :scheduled_at, :datetime

    Appointment.reset_column_information

    Appointment.where.not(date: nil).each do |appointment|
      date = appointment.date
      start_time = appointment.start_time
      scheduled_at = DateTime.new(date.year, date.month, date.day, start_time/100, start_time%100, 0, Time.zone.name).in_time_zone
      appointment.update_column(:scheduled_at, scheduled_at)
    end

    remove_column :appointments, :date
    remove_column :appointments, :start_time
    add_index :appointments, :scheduled_at
  end

  def down
    remove_index :appointments, :scheduled_at
    add_column :appointments, :date, :date
    add_column :appointments, :start_time, :integer

    Appointment.reset_column_information

    Appointment.where.not(date: nil).each do |appointment|
      appointment.update_columns(date: appointment.scheduled_at.to_date, start_time: appointment.scheduled_at.strftime('%H%M').to_i)
    end

    remove_column :appointments, :scheduled_at
    add_column :appointments, :end_time, :integer
  end
end
