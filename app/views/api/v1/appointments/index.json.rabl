collection :@appointments

attributes :id, :scheduled_at, :notes, :site_id
node(:outcome) {|appointment| appointment.outcome_string}

child(:assigned_to) do
  attributes :id, :fullname, :email
end

child(:created_by) do
  attributes :id, :fullname, :email
end

child(:follow_ups) do
  attributes :id, :scheduled_at, :notes
end