collection :@appointments
attributes :id, :date, :start_time_string, :end_time_string, :notes

child(:assigned_to) do
  attributes :id, :fullname, :email
end

child(:created_by) do
  attributes :id, :fullname, :email
end