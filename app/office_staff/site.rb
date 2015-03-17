ActiveAdmin.register Site, namespace: 'office_staff' do
  belongs_to :customer, optional: true

  actions :index, :show, :edit, :create, :update, :new
  scope :all, default: true
  permit_params :name, :contact_name, :contact_phone, :source, :damage, :status, :roof_built_at, :insurance_company, :claim_number, :mortgage_company, :loan_tracking_number, manager_ids: [], address_attributes: [:id, :address1, :address2, :city, :state_id, :zipcode, :customer_id]
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

  action_item 'Production', only: [:show, :edit] do
    if site.contract.present? && site.project.present?
      if site.production.present?
        link_to 'Production', office_staff_site_production_url(site, site.production)
      else
        link_to 'Create Production', new_office_staff_site_production_url(site)
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
    autocomplete :customer, :email, method_names: [:email, :firstname, :lastname], display_value: :autocomplete_display_value, extra_data: [:firstname, :lastname]

    private
      def get_autocomplete_where_clause(model, term, method, options)
        table_name = model.table_name
        is_full_search = options[:full]
        like_clause = (postgres?(model) ? 'ILIKE' : 'LIKE')
        where_clause = options[:method_names].collect do |meth|
          "LOWER(#{table_name}.#{meth}) #{like_clause} :term"
        end.join(' OR ')
        [where_clause, term: "#{(is_full_search ? '%' : '')}#{term.downcase}%"]
      end

      def ensure_manager
        params[:site][:manager_ids] ||= []
        params[:site][:manager_ids] << current_user.id.to_s if params[:site][:manager_ids].all?(&:blank?)
      end

      def scoped_collection
        super.includes(:managers, address: :state)
      end
  end

  index do
    column 'Site Name', sortable: true do |site|
      site.name
    end

    column 'Managers' do |site|
      site.managers.collect(&:email).join(', ')
    end

    column :contact_name
    column :contact_phone, sortable: false

    column 'Source' do |site|
      site.source_string
    end

    column 'Opportunity Priority' do |site|
      site.status_string
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
  filter :contact_name, as: :string
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

        row 'Phone Numbers' do |customer|
          customer.phone_numbers.pluck(:number).join(', ')
        end

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

      row :contact_name
      row :contact_phone

      row 'Source' do |site|
        site.source_string
      end

      row :damage
      row 'Opportunity Priority' do |site|
        site.status_string
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
          af.input :customer, required: true, as: :autocomplete, url: autocomplete_customer_email_office_staff_sites_path, input_html: { id_element: '.customer_id_element', value: af.object.customer.try(:autocomplete_display_value), placeholder: 'Search Email' }
          af.input :customer_id, as: :hidden, input_html: {class: 'customer_id_element'}
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
      f.input :contact_name
      f.input :contact_phone
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