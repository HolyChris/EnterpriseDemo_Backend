object :@project

extends 'api/v1/projects/show'

node(:errors, :if => lambda { |project| project.errors.present? }) do |project|
  project.errors
end