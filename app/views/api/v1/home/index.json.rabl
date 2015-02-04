object false

child :@recent_appointments => :appointments do
  collection @recent_appointments
  extends 'api/v1/appointments/create'
end

child :@recent_sites => :sites do
  collection @recent_sites
  extends 'api/v1/sites/create'
end

child :@recent_projects => :projects do
  collection @recent_projects
  extends 'api/v1/projects/create'
end
