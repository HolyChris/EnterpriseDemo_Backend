ActiveAdmin.register Production do
  menu false
  belongs_to :site
  actions :show, :edit, :create, :update, :new
  permit_params :ready_for_production_at, :delivery_date, :production_date, :paid_till_now, :roof_built_date, :production_inspection_date,
                :production_inspection_passed_date, :materials_not_used, :permit_number, :permit_date, :permit_department

  action_item 'Site', only: [:edit, :new, :show] do
    link_to 'Site', admin_site_url(site)
  end

  action_item 'Contract', only: [:edit, :new, :show] do
    link_to 'Contract', admin_site_contract_url(site, production.contract)
  end

  action_item 'Project', only: [:edit, :new, :show] do
    link_to 'Project', admin_site_project_url(site, production.project)
  end

  action_item 'Billing', only: [:show, :edit] do
    if site.billing.present?
      link_to 'Billing', admin_site_billing_url(production.site, production.billing)
    else
      link_to 'Create Billing', new_admin_site_billing_url(production.site)
    end
  end

  action_item 'Docs', only: [:show, :edit] do
    link_to 'Docs', admin_site_documents_url(production.site)
  end

  action_item 'Images', only: [:show, :edit] do
    link_to 'Images', admin_site_images_url(production.site)
  end

  action_item 'Cancel', only: [:edit] do
    link_to 'Cancel', admin_site_production_url(site, production)
  end

  controller do
    def scoped_collection
      if @site = Site.find_by(id: params[:site_id])
        Production.where(site_id: @site.id)
      end
    end
  end

  show do
    panel 'Production Info' do
      attributes_table_for production do
        row 'Project Received in Production' do
          production.ready_for_production_at
        end
        row :production_date
        row 'Materials Delivery Date' do
          production.delivery_date
        end
        row 'Paid Till Now' do
          number_to_currency(production.paid_till_now)
        end
        row :permit_number
        row :permit_date
        row :permit_department
      end
    end

    panel 'Completion Info' do
      attributes_table_for production do
        row 'Roof Completion Date' do
          production.roof_built_date
        end
        row :production_inspection_date
        row :production_inspection_passed_date
        row :materials_not_used
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    project = f.object

    f.inputs 'Production Info' do
      f.input :ready_for_production_at, as: :datepicker, input_html: {class: 'date-field'}, label: 'Project Received in Production'
      f.input :production_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :delivery_date, as: :datepicker, input_html: {class: 'date-field'}, label: 'Materials Delivery Date'
      f.input :paid_till_now
      f.input :permit_number
      f.input :permit_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :permit_department
    end

    f.inputs 'Completion Info' do
      f.input :roof_built_date, as: :datepicker, input_html: {class: 'date-field'}, label: 'Roof Completion Date'
      f.input :production_inspection_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :production_inspection_passed_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :materials_not_used
    end

    f.submit
  end
end