object :@document

attributes :id, :title, :notes
node(:doc_type) { |document| Asset::DOC_TYPE[document.doc_type] }
node(:stage) { |document| Site::STAGE.key(document.stage).try(:capitalize) }
child(:attachments) do
  attributes :id
  node(:file_name) { |attachment| attachment.file_file_name }
  node(:url) { |attachment| attachment.file.url }
end