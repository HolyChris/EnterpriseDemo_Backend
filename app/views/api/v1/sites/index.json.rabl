collection :@sites

attributes :id, :name
child(:customer) do
  attributes :email, :firstname, :lastname
end

child(:address) do
  attributes :address1, :address2, :city, :zipcode
  child(:state) do
    attributes :name
  end
end