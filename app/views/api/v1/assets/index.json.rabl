collection :@assets

attributes :id, :type, :attachment_file_name, :notes, :description, :alt
node(:url) { |asset| asset.attachment.url }
node(:stage) { |asset| Site::STAGE[asset.stage] }
