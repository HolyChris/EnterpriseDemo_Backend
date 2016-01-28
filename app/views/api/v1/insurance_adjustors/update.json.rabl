object :@insurance_adjustor

attributes :id, :name, :email, :telephone

node(:errors, :if => lambda { |insurance_adjustor| insurance_adjustor.errors.present? }) do |insurance_adjustor|
  insurance_adjustor.errors
end