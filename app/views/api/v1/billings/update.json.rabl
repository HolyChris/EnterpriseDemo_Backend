object :@billing

extends 'api/v1/billings/show'

node(:errors, :if => lambda { |billing| billing.errors.present? }) do |billing|
  billing.errors
end