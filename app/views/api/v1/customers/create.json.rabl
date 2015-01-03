object :@customer

attributes :id, :firstname, :lastname, :email, :spouse, :business_name, :other_business_info

child(:bill_address) do
  attributes :id, :address1, :address2, :city, :zipcode
  child(:state) do
    attributes :id, :name
  end
end

node(:errors, :if => lambda { |customer| customer.errors.present? }) do |customer|
  customer.errors
end