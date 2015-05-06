object :@site

attributes :id, :name, :source_info, :damage, :contact_name, :contact_phone

node(:bill_addr_same_as_addr) { |site| site.bill_addr_same_as_addr }
node(:stage) {|site| site.stage_string}
node(:po_number) {|site| site.po_number}
node(:source) {|site| site.source_string}
node(:status) {|site| site.status_string}

child(:customer) do
  attributes :id, :email, :firstname, :lastname

  child(:phone_numbers) do
    attributes :id, :number, :primary, :num_type
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