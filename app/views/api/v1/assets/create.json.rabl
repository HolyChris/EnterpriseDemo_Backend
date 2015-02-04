object :@asset

attributes :id. :title, :type, :attachment_file_name, :notes, :description, :alt
node(:doc_type) { |asset| Asset::DOC_TYPE[asset.doc_type] }
node(:url) { |asset| asset.attachment.url }
node(:stage) { |asset| Site::STAGE.key(asset.stage).try(:capitalize) }

node(:errors, :if => lambda { |asset| asset.errors.present? }) do |asset|
  asset.errors
end