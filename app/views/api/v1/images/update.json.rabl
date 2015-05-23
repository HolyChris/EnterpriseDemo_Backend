object :@image

extends 'api/v1/images/show'

node(:errors, :if => lambda { |image| image.errors.present? }) do |image|
  image.errors
end