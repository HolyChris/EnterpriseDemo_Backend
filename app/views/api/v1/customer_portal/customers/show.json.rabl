object false

#TODO: Data not complete

child :@customer => :customer do
  attribute :firstname, :lastname, :email, :spouse, :business_name
end

child :@site => :site do
  attribute :name
end

