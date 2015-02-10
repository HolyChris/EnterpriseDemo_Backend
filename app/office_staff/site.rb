ActiveAdmin.register Site, namespace: 'office_staff' do
  belongs_to :customer, optional: true

  actions :index, :show, :edit, :create, :update, :new
  scope :all, default: true
  permit_params :name, :source, :damage, :status, :roof_built_at, :insurance_company, :claim_number, :mortgage_company, :loan_tracking_number, manager_ids: [], address_attributes: [:id, :address1, :address2, :city, :state_id, :zipcode, :customer_id]
  before_filter :ensure_manager, only: [:create, :update]

  action_item 'Appointments', only: [:show, :edit] do
    link_to 'Appointments', office_staff_site_appointments_url(site)
  end

  action_item 'Contract', only: [:show, :edit] do
    if site.contract.present?
      link_to 'Contract', office_staff_site_contract_url(site, site.contract)
    else
      link_to 'Add Contract', new_office_staff_site_contract_url(site)
    end
  end

  action_item 'Project', only: [:show, :edit] do
    if site.contract.present?
      if site.project.present?
        link_to 'Project', office_staff_site_project_url(site, site.project)
      else
        link_to 'Create Project', new_office_staff_site_project_url(site)
      end
    end
  end

  action_item 'Docs', only: [:show, :edit] do
    link_to 'Docs', office_staff_site_documents_url(site)
  end

  action_item 'Images', only: [:show, :edit] do
    link_to 'Images', office_staff_site_images_url(site)
  end

  action_item 'Cancel', only: [:edit] do
    link_to 'Cancel', office_staff_site_url(site)
  end

  controller do
    private
      def ensure_manager
        params[:site][:manager_ids] ||= []
        params[:site][:manager_ids] << current_user.id.to_s if params[:site][:manager_ids].all?(&:blank?)
      end
  end

  index do
    column 'Site Name' do |site|
      site.name
    end

    column 'Managers' do |site|
      site.managers.pluck(:email).join(', ')
    end

    column 'Source' do |site|
      Site::SOURCE[site.source]
    end

    column 'Opportunity Priority' do |site|
      Site::STATUS[site.status]
    end
    column 'Address' do |site|
      site.address.full_address
    end

    actions do |site|
      link_to('Appointments', office_staff_site_appointments_url(site))
    end
  end

  filter :name, label: 'Site Name'
  filter :customer_email, as: :string
  # filter :managers_id, as: :select, collection: User.all.collect { |u| [u.email, u.id] }, label: 'Manager'
  filter :managers_email, as: :string, placeholder: 'Email', label: 'Manager'
  filter :source, as: :select, collection: Site::SOURCE.collect {|k,v| [v,k]}
  filter :status, as: :select, collection: Site::STATUS.collect {|k,v| [v,k]}, label: 'Opportunity Priority'
  filter :address_address1, as: :string, label: 'Address1'
  filter :address_address2, as: :string, label: 'Address2'
  filter :address_city, as: :string, label: 'City'
  filter :address_state_id, as: :select, collection: Country.default.states.order(:name).collect {|s| [s.name,s.id]}, label: 'State'
  filter :address_zipcode, as: :string, label: 'Zipcode'

  show do
    panel 'Customer Details' do
      attributes_table_for site.customer  do
        row :firstname
        row :lastname
        row :email
        row :spouse
        row :business_name
        row :other_business_info

        row 'Billing Address' do |customer|
          customer.bill_address.try(:full_address) || '-'
        end
      end
    end

    attributes_table do
      row 'Site Name' do |site|
        site.name
      end

      row 'Managers' do |site|
        site.managers.pluck(:email).join(', ')
      end

      row :stage

      row 'Address' do |site|
        site.address.full_address
      end

      row 'Source' do |site|
        Site::SOURCE[site.source]
      end

      row :damage
      row 'Opportunity Priority' do |site|
        Site::STATUS[site.status]
      end
      row :roof_built_at
      row :insurance_company
      row :claim_number, label: 'Claim #'
      row :mortgage_company
      row :loan_tracking_number, 'Loan Tracking #'
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.object.address ||= Address.new

    f.inputs 'Address' do
      f.fields_for :address do |af|
        if params[:customer_id]
          af.input :customer_id, as: :hidden, input_html: { value: params[:customer_id] }
        else
          af.input :customer_id, as: :select, collection: Customer.all.collect { |customer| [customer.fullname, customer.id] }
        end

        af.input :address1
        af.input :address2
        af.input :city
        af.input :state_id, as: :select, collection: State.order(:name).collect {|state| [state.name, state.id]  }
        af.input :zipcode
      end
    end

    f.inputs 'Details' do
      f.input :name, label: 'Site Name'
      f.input :manager_ids, as: :select, collection: User.all.collect {|user| [user.email, user.id]  }, multiple: true, input_html: { class: "chosen-select" }, label: 'Managers'
      f.input :source, as: :select, collection: Site::SOURCE.collect{|k,v| [v, k]}
      f.input :damage
      f.input :status, as: :select, collection: Site::STATUS.collect{|k,v| [v, k]}, label: 'Opportunity Priority'
      f.input :roof_built_at, as: :datepicker, input_html: {class: 'date-field'}
      f.input :insurance_company
      f.input :claim_number
      f.input :mortgage_company
      f.input :loan_tracking_number
    end

    f.submit
  end
end