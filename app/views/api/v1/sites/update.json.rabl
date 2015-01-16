object :@site

attributes :id, :name

child(:customer) do
  attributes :id, :email, :firstname, :lastname
end

child(:address) do
  attributes :id, :address1, :address2, :city, :zipcode
  child(:state) do
    attributes :id, :name
  end
end

child(:appointments) do
  attributes :id, :date, :start_time_string, :end_time_string, :notes
  child(:assigned_to) do
    attributes :id, :fullname, :email
  end

  child(:created_by) do
    attributes :id, :fullname, :email
  end
end

node(:errors, :if => lambda { |site| site.errors.present? }) do |site|
  site.errors
end