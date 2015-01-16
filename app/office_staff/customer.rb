ActiveAdmin.register Customer, namespace: 'office_staff' do
  actions :index, :show, :edit, :create, :update, :new
  scope :all, :default => true
  permit_params :firstname, :lastname, :email, :spouse, :business_name, :other_business_info, bill_address_attributes: [:address1, :address2, :city, :state_id, :zipcode], addresses_attributes: [:address1, :address2, :city, :state_id, :zipcode]

  action_item 'Sites', only: [:show, :edit] do
    link_to 'Sites', admin_customer_sites_url(customer)
  end

  action_item 'Cancel', only: [:edit] do
    link_to 'Cancel', admin_customer_url(customer)
  end

  controller do
  end

  index do
    column :firstname
    column :lastname
    column :email
    actions do |customer|
      link_to 'Sites', admin_customer_sites_url(customer)
    end
  end

  filter :firstname
  filter :lastname
  filter :email

  show do
    attributes_table do
      row :firstname
      row :lastname
      row :email
      row :spouse
      row :business_name
      row :other_business_info

      row 'Billing Address' do |site|
        customer.bill_address.try(:full_address) || '-'
      end
    end
  end

  form do |f|
    customer = f.object
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Details' do
      f.input :firstname, required: true
      f.input :lastname, required: true
      f.input :email, required: true
      f.input :spouse
      f.input :business_name
      f.input :other_business_info
      customer.bill_address ||= Address.new

      f.inputs 'Billing Address' do
        f.fields_for :bill_address do |baf|
          baf.input :address1, required: true
          baf.input :address2
          baf.input :city, required: true
          baf.input :state_id, as: :select, collection: State.all.collect {|state| [state.name, state.id]  }, required: true
          baf.input :zipcode, required: true
        end
      end
    end

    f.submit
  end
end