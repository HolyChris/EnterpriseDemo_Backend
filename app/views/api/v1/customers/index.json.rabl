object false
node(:total_pages) { @customers.total_pages }
node(:total_count) { @customers.total_count }

child :@customers => :customers do
  extends 'api/v1/customers/show'
end