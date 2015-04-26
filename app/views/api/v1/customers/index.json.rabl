collection :@customers

attributes :id, :firstname, :lastname, :email, :spouse, :business_name, :other_business_info

child(:phone_numbers) do
  attributes :id, :number, :primary, :num_type
end

child(:sites) do
  attributes :id, :name, :damage, :roof_built_at, :insurance_company, :claim_number, :mortgage_company, :loan_tracking_number, :contact_name, :contact_phone

  node(:source) {|site| site.source_string}
  node(:status) {|site| site.status_string}

  child(:address) do
    attributes :id, :address1, :address2, :city, :zipcode
    child(:state) do
      attributes :id, :name
    end
  end

  child(:bill_address) do
    attributes :id, :address1, :address2, :city, :zipcode
    child(:state) do
      attributes :id, :name
    end
  end
end
