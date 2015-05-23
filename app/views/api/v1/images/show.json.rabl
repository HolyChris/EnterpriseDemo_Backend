object :@image

attributes :id, :title, :notes
node(:stage) { |image| Site::STAGE.key(image.stage).try(:capitalize) }
child(:attachments) do
  attributes :id
  node(:file_name) { |attachment| attachment.file_file_name }
  node(:url) { |attachment| attachment.file.url }
end