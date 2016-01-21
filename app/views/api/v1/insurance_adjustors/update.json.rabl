object :@insurance_adjustor

extends 'api/v1/insurance_adjustors/show'

node(:errors, :if => lambda { |insurance_adjustor| insurance_adjustor.errors.present? }) do |insurance_adjustor|
  insurance_adjustor.errors
end