object :@contract

extends 'api/v1/contracts/show'

node(:errors, :if => lambda { |contract| contract.errors.present? }) do |contract|
  contract.errors
end