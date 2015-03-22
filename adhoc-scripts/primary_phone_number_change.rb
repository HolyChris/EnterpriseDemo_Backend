require File.expand_path(File.join(File.dirname(__FILE__), '../config', 'environment'))

no_phone_customer = []
other_type = PhoneNumber::NUM_TYPE.key('Other')
Customer.all.each do |customer|
  customer.phone_numbers.update_all(num_type: other_type)
  if customer.primary_phone_number.blank?
    if prime = customer.phone_numbers.first
      prime.update_column(:primary, true)
    else
      no_phone_customer << customer.id
    end
  end
end

p no_phone_customer