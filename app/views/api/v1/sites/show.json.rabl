object :@site

attributes :id, :name, :source_info, :damage, :contact_name, :contact_phone

node(:bill_addr_same_as_addr) { |site| site.bill_addr_same_as_addr }
node(:stage) {|site| site.stage_string}
node(:po_number) {|site| site.po_number}
node(:source) {|site| site.source_string}
node(:status) {|site| site.status_string}

child(:customer) do
  attributes :id, :email, :firstname, :lastname, :spouse, :business_name, :other_business_info

  child(:phone_numbers) do
    attributes :id, :number, :primary, :num_type, :num_type_string
  end
end

child(:contract) do
  attributes :id, :po_number, :signed_at, :notes, :special_instructions

  node(:contract_type) {|contract| contract.type_string}
  node(:price) { |contract| number_to_currency(contract.price) }
  node(:document_url) {|contract| contract.document.url}
  node(:ers_sign_image_url) {|contract| contract.ers_sign_image.url}
  node(:customer_sign_image_url) {|contract| contract.customer_sign_image.url}

  child(:work_types) do
    attributes :id, :name
  end
end

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

child(:appointments) do
  attributes :id, :scheduled_at, :notes
  node(:outcome) {|appointment| appointment.outcome_string}

  child(:assigned_to) do
    attributes :id, :fullname, :email
  end

  child(:created_by) do
    attributes :id, :fullname, :email
  end

  child(:follow_ups) do
    attributes :id, :scheduled_at, :notes
  end
end

child :assets do
  attributes :id, :title, :type, :notes
  node(:doc_type) { |asset| Asset::DOC_TYPE[asset.doc_type] }
  node(:stage) { |asset| Site::STAGE.key(asset.stage).try(:capitalize) }
  child(:attachments) do
    attributes :id
    node(:file_name) { |attachment| attachment.file_file_name }
    node(:url) { |attachment| attachment.file.url }
  end
end

child :managers do
  attributes :id, :email, :firstname, :lastname
end