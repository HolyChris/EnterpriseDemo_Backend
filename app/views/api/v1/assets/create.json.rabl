object :@asset

attributes :id, :type, :attachment_file_name, :notes, :description, :alt
node(:url) { |asset| asset.attachment.url }
node(:stage) { |asset| Site::STAGE.key(asset.stage).try(:capitalize) }

node(:errors, :if => lambda { |asset| asset.errors.present? }) do |asset|
  asset.errors
end