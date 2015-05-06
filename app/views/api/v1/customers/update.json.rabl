object :@customer

extends 'api/v1/customers/show'

node(:errors, :if => lambda { |customer| customer.errors.present? }) do |customer|
  customer.errors
end