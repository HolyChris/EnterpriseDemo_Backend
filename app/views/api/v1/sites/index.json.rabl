collection :@sites

attributes :id, :name, :damage, :roof_built_at, :insurance_company, :claim_number, :mortgage_company, :loan_tracking_number, :contact_name, :contact_phone

node(:source) {|site| Site::SOURCE[site.source]}
node(:status) {|site| Site::STATUS[site.status]}

child(:customer) do
  attributes :id, :email, :firstname, :lastname

  child(:phone_numbers) do
    attributes :id, :number
  end
end

child(:address) do
  attributes :id, :address1, :address2, :city, :zipcode
  child(:state) do
    attributes :id, :name
  end
end

child(:appointments) do
  attributes :id, :date, :start_time_string, :end_time_string, :notes
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
  attributes :id, :title, :type, :notes, :alt
  node(:doc_type) { |asset| Asset::DOC_TYPE[asset.doc_type] }
  node(:stage) { |asset| Site::STAGE.key(asset.stage).try(:capitalize) }
  child(:attachments) do
    attributes :id
    node(:file_name) { |attachment| attachment.file_file_name }
    node(:url) { |attachment| attachment.file.url }
  end
end
