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

[{ name: 'Michigan', abbr: 'MI', country: country },
  { name: 'South Dakota', abbr: 'SD', country: country },
  { name: 'Washington', abbr: 'WA', country: country },
  { name: 'Wisconsin', abbr: 'WI', country: country },
  { name: 'Arizona', abbr: 'AZ', country: country },
  { name: 'Illinois', abbr: 'IL', country: country },
  { name: 'New Hampshire', abbr: 'NH', country: country },
  { name: 'North Carolina', abbr: 'NC', country: country },
  { name: 'Kansas', abbr: 'KS', country: country },
  { name: 'Missouri', abbr: 'MO', country: country },
  { name: 'Arkansas', abbr: 'AR', country: country },
  { name: 'Nevada', abbr: 'NV', country: country },
  { name: 'District of Columbia', abbr: 'DC', country: country },
  { name: 'Idaho', abbr: 'ID', country: country },
  { name: 'Nebraska', abbr: 'NE', country: country },
  { name: 'Pennsylvania', abbr: 'PA', country: country },
  { name: 'Hawaii', abbr: 'HI', country: country },
  { name: 'Utah', abbr: 'UT', country: country },
  { name: 'Vermont', abbr: 'VT', country: country },
  { name: 'Delaware', abbr: 'DE', country: country },
  { name: 'Rhode Island', abbr: 'RI', country: country },
  { name: 'Oklahoma', abbr: 'OK', country: country },
  { name: 'Louisiana', abbr: 'LA', country: country },
  { name: 'Montana', abbr: 'MT', country: country },
  { name: 'Tennessee', abbr: 'TN', country: country },
  { name: 'Maryland', abbr: 'MD', country: country },
  { name: 'Florida', abbr: 'FL', country: country },
  { name: 'Virginia', abbr: 'VA', country: country },
  { name: 'Minnesota', abbr: 'MN', country: country },
  { name: 'New Jersey', abbr: 'NJ', country: country },
  { name: 'Ohio', abbr: 'OH', country: country },
  { name: 'California', abbr: 'CA', country: country },
  { name: 'North Dakota', abbr: 'ND', country: country },
  { name: 'Maine', abbr: 'ME', country: country },
  { name: 'Indiana', abbr: 'IN', country: country },
  { name: 'Texas', abbr: 'TX', country: country },
  { name: 'Oregon', abbr: 'OR', country: country },
  { name: 'Wyoming', abbr: 'WY', country: country },
  { name: 'Alabama', abbr: 'AL', country: country },
  { name: 'Iowa', abbr: 'IA', country: country },
  { name: 'Mississippi', abbr: 'MS', country: country },
  { name: 'Kentucky', abbr: 'KY', country: country },
  { name: 'New Mexico', abbr: 'NM', country: country },
  { name: 'Georgia', abbr: 'GA', country: country },
  { name: 'Colorado', abbr: 'CO', country: country },
  { name: 'Massachusetts', abbr: 'MA', country: country },
  { name: 'Connecticut', abbr: 'CT', country: country },
  { name: 'New York', abbr: 'NY', country: country },
  { name: 'South Carolina', abbr: 'SC', country: country },
  { name: 'Alaska', abbr: 'AK', country: country },
  { name: 'West Virginia', abbr: 'WV', country: country },
  { name: 'U.S. Armed Forces - Americas', abbr: 'AA', country: country },
  { name: 'U.S. Armed Forces - Europe', abbr: 'AE', country: country },
  { name: 'U.S. Armed Forces - Pacific', abbr: 'AP', country: country }
].each do |state_details|
  State.find_or_create_by!(state_details)
end
