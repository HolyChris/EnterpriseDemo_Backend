object :@appointment

attributes :id, :scheduled_at, :notes
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

node(:errors, :if => lambda { |appointment| appointment.errors.present? }) do |appointment|
  appointment.errors
end