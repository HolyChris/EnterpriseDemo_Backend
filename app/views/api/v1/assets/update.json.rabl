object :@asset

attributes :id, :title, :type, :notes
node(:doc_type) { |asset| Asset::DOC_TYPE[asset.doc_type] }
node(:stage) { |asset| Site::STAGE.key(asset.stage).try(:capitalize) }
child(:attachments) do
  attributes :id
  node(:file_name) { |attachment| attachment.file_file_name }
  node(:url) { |attachment| attachment.file.url }
end

node(:errors, :if => lambda { |asset| asset.errors.present? }) do |asset|
  asset.errors
end