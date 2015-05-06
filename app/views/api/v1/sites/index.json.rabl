object false
node(:total_pages) { @sites.total_pages }
node(:total_count) { @sites.total_count }

child :@sites => :sites do
  extends 'api/v1/sites/show'
end