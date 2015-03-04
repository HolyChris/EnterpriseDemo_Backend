collection :@appointments
attributes :id, :date, :start_time_string, :end_time_string, :notes

child(:assigned_to) do
  attributes :id, :fullname, :email
end

child(:created_by) do
  attributes :id, :fullname, :email
end

child(:follow_ups) do
  attributes :id, :scheduled_at, :notes
end