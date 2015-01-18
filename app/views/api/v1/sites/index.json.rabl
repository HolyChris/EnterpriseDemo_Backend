collection :@sites

attributes :id, :name
child(:customer) do
  attributes :id, :email, :firstname, :lastname
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
end

child :assets do
  attributes :id, :type, :attachment_file_name, :notes, :description, :alt
  node(:url) { |asset| asset.attachment.url }
  node(:stage) { |asset| Site::STAGE[asset.stage] }
end
