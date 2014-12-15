ActiveAdmin.register_page 'Settings', namespace: 'sales_rep' do
  menu :priority => 20, url: :edit_user_registration_url
end