require File.expand_path(File.join(File.dirname(__FILE__), '../config', 'environment'))

users_info = [
  {firstname: 'Lindsey', lastname: 'Noftsger', email: 'lnoftsger@ecoroofandsolar.com', password: '12345678', roles: [:office_staff, :sales_rep]},
  {firstname: 'Alex', lastname: 'Lingenfelter', email: 'alingenfelter@ecoroofandsolar.com', password: '12345678', roles: [:office_staff, :sales_rep]},
  {firstname: 'Ryan', lastname: 'Nichols', email: 'rnichols@ecoroofandsolar.com', password: '12345678', roles: [:admin, :office_staff]},
  {firstname: 'Patric', lastname: 'Bohn', email: 'pbohn@ecoroofandsolar.com', password: '12345678', roles: [:office_staff, :sales_rep]},
  {firstname: 'Jespinosa', email: 'jespinosa@ecoroofandsolar.com', password: '12345678', roles: [:office_staff]},
  {firstname: 'Phebein', email: 'phebein@ecoroofandsolar.com', password: '12345678', roles: [:office_staff]},
  {firstname: 'Vandrews', email: 'vandrews@ecoroofandsolar.com', password: '12345678', roles: [:office_staff]},
  {firstname: 'Brandy', lastname: 'Menghi', email: 'bmenghi@ecoroofandsolar.com', password: '12345678', roles: [:office_staff]}
]

roles = {office_staff: Role.find_by(name: 'office_staff'), sales_rep: Role.find_by(name: 'sales_rep'), admin: Role.find_by(name: 'admin')}

users_info.each do |user_info|
  if User.find_by(email: user_info[:email]).blank?
    user_info_roles = user_info.delete(:roles)
    user = User.new(user_info)
    user.password_confirmation = user_info[:password]
    user.save!

    user_info_roles.each do |role|
      user.roles << roles[role]
    end
  end
end