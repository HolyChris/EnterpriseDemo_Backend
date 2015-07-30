object :@appointment

attributes :id, :notes
node(:scheduled_at) {|appointment| appointment.scheduled_at.try(:iso8601) }
node(:outcome) {|appointment| appointment.outcome_string}

child(:assigned_to) do
  attributes :id, :fullname, :email
end

child(:created_by) do
  attributes :id, :fullname, :email
end

child(:follow_ups) do
  attributes :id, :notes
  node(:scheduled_at) {|follow_up| follow_up.scheduled_at.try(:iso8601) }
end

node(:errors, :if => lambda { |appointment| appointment.errors.present? }) do |appointment|
  appointment.errors
end
