object :@customer

attributes :id, :firstname, :lastname, :email, :spouse, :business_name, :other_business_info

child(:phone_numbers) do
  attributes :id, :number, :primary, :num_type
end

child(:sites) do
  attributes :id, :name, :source_info, :damage, :contact_name, :contact_phone

  node(:bill_addr_same_as_addr) { |site| site.bill_addr_same_as_addr }
  node(:stage) {|site| site.stage_string}
  node(:po_number) {|site| site.po_number}
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
