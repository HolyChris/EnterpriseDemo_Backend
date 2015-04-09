ActiveAdmin.register Customer, namespace: 'sales_rep' do
  menu priority: 2
  actions :index, :show, :edit, :create, :update, :new
  scope :all, default: true
  permit_params :firstname, :lastname, :email, :spouse, :business_name, :other_business_info, bill_address_attributes: [:address1, :address2, :city, :state_id, :zipcode], phone_numbers_attributes: [:number, :primary, :num_type, :id, :_destroy]

  action_item 'Sites', only: [:show, :edit] do
    link_to 'Sites', sales_rep_customer_sites_url(customer)
  end

  action_item 'Cancel', only: [:edit] do
    link_to 'Cancel', sales_rep_customer_url(customer)
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
      link_to 'Sites', sales_rep_customer_sites_url(customer)
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

      row 'Billing Address' do |customer|
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

      customer.bill_address ||= Address.new

      f.inputs 'Billing Address' do
        f.fields_for :bill_address do |baf|
          baf.input :address1, required: true
          baf.input :address2
          baf.input :city, required: true
          baf.input :state_id, as: :select, collection: State.order(:name).collect {|state| [state.name, state.id]  }, required: true
          baf.input :zipcode, required: true
        end
      end
    end

    f.submit
  end
end