object :@site

extends 'api/v1/sites/show'

node(:errors, :if => lambda { |site| site.errors.present? }) do |site|
  site.errors
end