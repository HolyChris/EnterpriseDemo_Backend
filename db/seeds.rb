## Creating Roles
%w(admin office_staff sales_rep production_rep billing_rep).each do |type|
  Role.find_or_create_by(name: type)
end

##Creating Admin
user1 = User.create_with(
  password: 'admin123',
  password_confirmation: 'admin123'
).find_or_create_by(email: 'priyankgupta1988@gmail.com')
user1.add_role :admin

user1 = User.create_with(
  password: 'admin123',
  password_confirmation: 'admin123'
).find_or_create_by(email: 'marcin@toptal.com')
user1.add_role :admin

user2 = User.create_with(
  password: 'salesrep123',
  password_confirmation: 'salesrep123'
).find_or_create_by(email: 'priyank@test.com')
user2.add_role :sales_rep

user3 = User.create_with(
  password: 'officestaff123',
  password_confirmation: 'officestaff123'
).find_or_create_by(email: 'office_staff@test.com')
user3.add_role :office_staff


[{ name: "United States", iso3: "USA", iso: "US", iso_name: "UNITED STATES", numcode: "840" }
].each do |country_details|
  Country.find_or_create_by!(country_details)
end

country = Country.find_by(name: 'United States')

[
  { id: 1, name: 'Michigan', abbr: 'MI', country: country },
  { id: 2, name: 'South Dakota', abbr: 'SD', country: country },
  { id: 3, name: 'Washington', abbr: 'WA', country: country },
  { id: 4, name: 'Wisconsin', abbr: 'WI', country: country },
  { id: 5, name: 'Arizona', abbr: 'AZ', country: country },
  { id: 6, name: 'Illinois', abbr: 'IL', country: country },
  { id: 7, name: 'New Hampshire', abbr: 'NH', country: country },
  { id: 8, name: 'North Carolina', abbr: 'NC', country: country },
  { id: 9, name: 'Kansas', abbr: 'KS', country: country },
  { id: 10, name: 'Missouri', abbr: 'MO', country: country },
  { id: 11, name: 'Arkansas', abbr: 'AR', country: country },
  { id: 12, name: 'Nevada', abbr: 'NV', country: country },
  # { id: 13, name: 'District of Columbia', abbr: 'DC', country: country },
  { id: 14, name: 'Idaho', abbr: 'ID', country: country },
  { id: 15, name: 'Nebraska', abbr: 'NE', country: country },
  { id: 16, name: 'Pennsylvania', abbr: 'PA', country: country },
  { id: 17, name: 'Hawaii', abbr: 'HI', country: country },
  { id: 18, name: 'Utah', abbr: 'UT', country: country },
  { id: 19, name: 'Vermont', abbr: 'VT', country: country },
  { id: 20, name: 'Delaware', abbr: 'DE', country: country },
  { id: 21, name: 'Rhode Island', abbr: 'RI', country: country },
  { id: 22, name: 'Oklahoma', abbr: 'OK', country: country },
  { id: 23, name: 'Louisiana', abbr: 'LA', country: country },
  { id: 24, name: 'Montana', abbr: 'MT', country: country },
  { id: 25, name: 'Tennessee', abbr: 'TN', country: country },
  { id: 26, name: 'Maryland', abbr: 'MD', country: country },
  { id: 27, name: 'Florida', abbr: 'FL', country: country },
  { id: 28, name: 'Virginia', abbr: 'VA', country: country },
  { id: 29, name: 'Minnesota', abbr: 'MN', country: country },
  { id: 30, name: 'New Jersey', abbr: 'NJ', country: country },
  { id: 31, name: 'Ohio', abbr: 'OH', country: country },
  { id: 32, name: 'California', abbr: 'CA', country: country },
  { id: 33, name: 'North Dakota', abbr: 'ND', country: country },
  { id: 34, name: 'Maine', abbr: 'ME', country: country },
  { id: 35, name: 'Indiana', abbr: 'IN', country: country },
  { id: 36, name: 'Texas', abbr: 'TX', country: country },
  { id: 37, name: 'Oregon', abbr: 'OR', country: country },
  { id: 38, name: 'Wyoming', abbr: 'WY', country: country },
  { id: 39, name: 'Alabama', abbr: 'AL', country: country },
  { id: 40, name: 'Iowa', abbr: 'IA', country: country },
  { id: 41, name: 'Mississippi', abbr: 'MS', country: country },
  { id: 42, name: 'Kentucky', abbr: 'KY', country: country },
  { id: 43, name: 'New Mexico', abbr: 'NM', country: country },
  { id: 44, name: 'Georgia', abbr: 'GA', country: country },
  { id: 45, name: 'Colorado', abbr: 'CO', country: country },
  { id: 46, name: 'Massachusetts', abbr: 'MA', country: country },
  { id: 47, name: 'Connecticut', abbr: 'CT', country: country },
  { id: 48, name: 'New York', abbr: 'NY', country: country },
  { id: 49, name: 'South Carolina', abbr: 'SC', country: country },
  { id: 50, name: 'Alaska', abbr: 'AK', country: country },
  { id: 51, name: 'West Virginia', abbr: 'WV', country: country }
  # { id: 52, name: 'U.S. Armed Forces - Americas', abbr: 'AA', country: country },
  # { id: 53, name: 'U.S. Armed Forces - Europe', abbr: 'AE', country: country },
  # { id: 54, name: 'U.S. Armed Forces - Pacific', abbr: 'AP', country: country }
].each do |state_details|
  State.find_or_create_by!(state_details)
end
