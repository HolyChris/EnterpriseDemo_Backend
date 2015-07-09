object :@production

extends 'api/v1/billings/show'

node(:errors, :if => lambda { |production| production.errors.present? }) do |production|
  production.errors
end