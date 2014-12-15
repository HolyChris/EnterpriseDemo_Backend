## Creating Roles
%w(admin sales_rep).each do |type|
  Role.find_or_create_by(name: type)
end

##Creating Admin
user1 = User.create_with(
  password: 'admin123',
  password_confirmation: 'admin123'
).find_or_create_by(email: 'priyankgupta1988@gmail.com')
user1.add_role :admin

user2 = User.create_with(
  password: 'salesrep123',
  password_confirmation: 'salesrep123'
).find_or_create_by(email: 'priyank@test.com')
user2.add_role :sales_rep