collection :@customers

attributes :id, :firstname, :lastname, :email, :spouse, :business_name, :other_business_info

child(:bill_address) do
  attributes :id, :address1, :address2, :city, :zipcode
  child(:state) do
    attributes :id, :name
  end
end

child(:sites) do
  attributes :id, :name, :damage, :roof_built_at, :insurance_company, :claim_number, :mortgage_company, :loan_tracking_number

  node(:source) {|site| Site::SOURCE[site.source]}
  node(:status) {|site| Site::STATUS[site.status]}

  child(:address) do
    attributes :id, :address1, :address2, :city, :zipcode
    child(:state) do
      attributes :id, :name
    end
  end
end
