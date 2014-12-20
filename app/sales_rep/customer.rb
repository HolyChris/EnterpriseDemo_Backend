ActiveAdmin.register Customer, namespace: 'sales_rep' do
  actions :index, :show, :edit, :create, :update, :new
  scope :all, :default => true
  permit_params :firstname, :lastname, :email, :phone, :alt_phone

  controller do
  end

  index do
    column :id
    column :firstname
    column :lastname
    column :email
    column :phone
    column :alt_phone
  end
end