object :@asset

extends 'api/v1/assets/show'

node(:errors, :if => lambda { |asset| asset.errors.present? }) do |asset|
  asset.errors
end