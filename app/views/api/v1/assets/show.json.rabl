object :@asset

attributes :id, :title, :type, :notes
node(:doc_type) { |asset| Asset::DOC_TYPE[asset.doc_type] }
node(:stage) { |asset| Site::STAGE_MAPPING[Site::STAGE.key(asset.stage)] }
child(:attachments) do
  attributes :id
  node(:file_name) { |attachment| attachment.file_file_name }
  node(:url) { |attachment| attachment.file.url }
  node(:thumbnail_url) { |attachment| attachment.file.url(:thumb) }
  node(:upload){ |attachment| attachment.to_jq_upload}
end
