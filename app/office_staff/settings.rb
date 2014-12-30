ActiveAdmin.register_page 'Settings', namespace: 'office_staff' do
  menu :priority => 20, url: :edit_user_registration_url
end