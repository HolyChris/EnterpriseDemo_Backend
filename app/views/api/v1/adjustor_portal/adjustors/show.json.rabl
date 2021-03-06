object false

child :@project => :project do
  node(:po_number) { @site.po_number }
  node(:stage) { @site.stage }
  node(:contract_signed_date) { @site.contract.try(:signed_at) }
  node(:contract_document_url) {|contract| @site.contract.document.url}
  node(:material_delivery_date) { @site.production.try(:delivery_date) }
  node(:production_date) { @site.production.try(:production_date) }
  node(:roof_completion_date) { @site.production.roof_built_date }
  node(:production_inspection_date) { @site.production.production_inspection_date }
end

child :@customer => :customer do
  attribute :firstname, :lastname, :email, :spouse, :business_name, :other_business_info
  child(:phone_numbers) do
    attributes :number, :primary, :num_type
  end
end

child :@site => :site do
  attribute :name, :contact_name
  node(:cover_photo_url) {|site| site.cover_photo.url}
  child :managers do
    attributes :id, :email, :firstname, :lastname
    node(:primary) {|manager| manager.site_managers.find_by(site: @site).try(:primary)  }
  end
  child(:address) do
    attributes :address1, :address2, :city, :zipcode
    node(:state) {|address| address.state.name }
  end


child :assets do
  attributes :id, :title, :type, :notes
  node(:doc_type) { |asset| Asset::DOC_TYPE[asset.doc_type] }
  node(:stage) { |asset| Site::STAGE_MAPPING[Site::STAGE.key(asset.stage)] }
  child(:attachments) do
    attributes :id
    node(:file_name) { |attachment| attachment.file_file_name }
    node(:url) { |attachment| attachment.file.url }
    node(:thumbnail_url) { |attachment| attachment.file.url(:thumb) }
  end
end


end


