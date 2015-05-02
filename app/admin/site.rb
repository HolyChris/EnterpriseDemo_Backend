ActiveAdmin.register Site do
  menu priority: 3
  belongs_to :customer, optional: true

  actions :index, :show, :edit, :create, :update, :new
  scope :all, default: true
  permit_params :name, :contact_name, :contact_phone, :source, :source_info, :damage, :status, :bill_addr_same_as_addr, manager_ids: [], bill_address_attributes: [:id, :address1, :address2, :city, :state_id, :zipcode], address_attributes: [:id, :address1, :address2, :city, :state_id, :zipcode, :customer_id]
  before_filter :ensure_manager, only: [:create, :update]
  before_filter :manage_params, only: [:create, :update]

  action_item 'Appointments', only: [:show, :edit] do
    link_to 'Appointments', admin_site_appointments_url(site)
  end

  action_item 'Contract', only: [:show, :edit] do
    if site.contract.present?
      link_to 'Contract', admin_site_contract_url(site, site.contract)
    else
      link_to 'Add Contract', new_admin_site_contract_url(site)
    end
  end

  action_item 'Project', only: [:show, :edit] do
    if site.contract.present?
      if site.project.present?
        link_to 'Project', admin_site_project_url(site, site.project)
      else
        link_to 'Create Project', new_admin_site_project_url(site)
      end
    end
  end

  action_item 'Production', only: [:show, :edit] do
    if site.contract.present? && site.project.present?
      if site.production.present?
        link_to 'Production', admin_site_production_url(site, site.production)
      else
        link_to 'Create Production', new_admin_site_production_url(site)
      end
    end
  end

  action_item 'Docs', only: [:show, :edit] do
    link_to 'Docs', admin_site_documents_url(site)
  end

  action_item 'Images', only: [:show, :edit] do
    link_to 'Images', admin_site_images_url(site)
  end

  action_item 'Cancel', only: [:edit] do
    link_to 'Cancel', admin_site_url(site)
  end

  controller do
    def autocomplete_site_customer
      @customers = Customer.includes(:primary_phone_number).joins(:phone_numbers).where('firstname like :term OR lastname like :term OR phone_numbers.number like :term', term: "%#{params[:term].downcase}%").uniq.order(firstname: :asc).limit(10).collect do |cust|
        cust.attributes.merge(value: cust.autocomplete_display_value, label: cust.autocomplete_display_value)
      end

      render json: @customers
    end

    private
      def manage_params
        if params[:site][:bill_addr_same_as_addr] == '1'
          params[:site].delete(:bill_address_attributes)
        end
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

    column 'Site Contact Name' do |site|
      site.contact_name
    end

    column 'Site Contact Phone' do |site|
      site.contact_phone
    end

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
      link_to('Appointments', admin_site_appointments_url(site))
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
      end
    end

    attributes_table do
      if site.po_number
        row 'PO#' do |site|
          site.po_number
        end
      end

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

      row 'Billing Address' do |site|
        site.bill_address.try(:full_address) || '-'
      end

      row 'Site Contact Name' do |site|
        site.contact_name
      end

      row 'Site Contact Phone' do |site|
        site.contact_phone
      end

      row 'Source' do |site|
        site.source_string
      end

      row :source_info

      row :damage
      row 'Opportunity Priority' do |site|
        site.status_string
      end
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
          af.input :customer, required: true, as: :autocomplete, url: autocomplete_site_customer_admin_sites_path, input_html: { id_element: '.customer_id_element', value: af.object.customer.try(:autocomplete_display_value), placeholder: 'Search Name or Primary Phone' }
          af.input :customer_id, as: :hidden, input_html: {class: 'customer_id_element'}
        end

        af.input :address1
        af.input :address2
        af.input :city
        af.input :state_id, as: :select, collection: State.order(:name).collect {|state| [state.name, state.id]  }
        af.input :zipcode
      end
    end

    f.inputs 'Billing Address' do
      f.input :bill_addr_same_as_addr, as: :boolean, input_html: { id: 'bill_addr_same_as_addr_check' }, label: 'Same as Site Address?'

      if f.object.bill_addr_same_as_addr
        f.object.bill_address = Address.new
      else
        f.object.bill_address ||= Address.new
      end

      f.fields_for :bill_address do |baf|
        baf.input :address1, required: true
        baf.input :address2
        baf.input :city, required: true
        baf.input :state_id, as: :select, collection: State.order(:name).collect {|state| [state.name, state.id]  }, required: true
        baf.input :zipcode, required: true
      end
    end

    f.inputs 'Site Details' do
      if f.object.po_number
        f.input :po_number, input_html: { disabled: true }, label: 'PO#'
      end
      f.input :stage_string, input_html: { disabled: true }, label: 'Stage'
      f.input :name, label: 'Site Name'
      f.input :manager_ids, as: :select, collection: User.all.collect {|user| [user.email, user.id]  }, multiple: true, input_html: { class: "chosen-select" }, label: 'Managers'
      f.input :contact_name, label: 'Site Contact Name'
      f.input :contact_phone, label: 'Site Contact Phone'
      f.input :source, as: :select, collection: Site::SOURCE.collect{|k,v| [v, k]}
      f.input :source_info
      f.input :damage
      f.input :status, as: :select, collection: Site::STATUS.collect{|k,v| [v, k]}, label: 'Opportunity Priority'
    end

    f.submit
  end
end