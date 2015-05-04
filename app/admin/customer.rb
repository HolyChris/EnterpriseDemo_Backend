ActiveAdmin.register Customer do
  menu priority: 2
  actions :index, :show, :edit, :create, :update, :new
  scope :all, default: true
  permit_params :firstname, :lastname, :email, :spouse, :business_name, :other_business_info, phone_numbers_attributes: [:number, :primary, :num_type, :id, :_destroy]

  action_item 'Sites', only: [:show, :edit] do
    link_to 'Sites', admin_customer_sites_url(customer)
  end

  action_item 'Cancel', only: [:edit] do
    link_to 'Cancel', admin_customer_url(customer)
  end

  controller do
    def scoped_collection
      super.includes(:primary_phone_number)
    end
  end

  index do
    column :firstname
    column :lastname
    column :email

    column 'Phone Number' do |customer|
      customer.primary_phone_number.try(:number_string)
    end

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

      row 'Phone Numbers' do |customer|
        customer.phone_numbers.collect { |pn| pn.number_string }.join(', ')
      end
    end
  end

  form do |f|
    customer = f.object
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Details' do
      f.input :firstname, required: true
      f.input :lastname, required: true
      f.input :email
      f.input :spouse
      f.input :business_name
      f.input :other_business_info

      customer.phone_numbers.present? || customer.phone_numbers.primary.build
      f.has_many :phone_numbers do |pnf|
        pnf.input :number
        pnf.input :num_type, as: :select, collection: PhoneNumber::NUM_TYPE.collect{|k,v| [v, k] }, label: 'Type'
        pnf.input :primary, input_html: { class: 'behave_radio1' }
        pnf.input :_destroy, as: :boolean, label: 'Remove'
      end
    end

    f.submit
  end
end