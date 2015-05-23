object :@document

extends 'api/v1/documents/show'

node(:errors, :if => lambda { |document| document.errors.present? }) do |document|
  document.errors
end