ActiveAdmin.register Production, namespace: 'office_staff' do
  menu false
  belongs_to :site
  actions :show, :edit, :create, :update, :new
  permit_params :delivery_date, :production_date, :paid_till_now, :roof_built_date, :production_inspection_date,
                :production_inspection_passed_date, :materials_not_used, :permit_number, :permit_date, :permit_department

  action_item 'Site', only: [:edit, :new, :show] do
    link_to 'Site', office_staff_site_url(site)
  end

  action_item 'Contract', only: [:edit, :new, :show] do
    link_to 'Contract', office_staff_site_contract_url(site, production.contract)
  end

  action_item 'Project', only: [:edit, :new, :show] do
    link_to 'Project', office_staff_site_project_url(site, production.project)
  end

  action_item 'Billing', only: [:show, :edit] do
    if site.billing.present?
      link_to 'Billing', office_staff_site_billing_url(production.site, production.billing)
    else
      link_to 'Create Billing', new_office_staff_site_billing_url(production.site)
    end
  end

  action_item 'Docs', only: [:show, :edit] do
    link_to 'Docs', office_staff_site_documents_url(production.site)
  end

  action_item 'Images', only: [:show, :edit] do
    link_to 'Images', office_staff_site_images_url(production.site)
  end

  action_item 'Cancel', only: [:edit] do
    link_to 'Cancel', office_staff_site_production_url(site, production)
  end

  controller do
    def scoped_collection
      if @site = Site.find_by(id: params[:site_id])
        Production.where(site_id: @site.id)
      end
    end
  end

  show do
    attributes_table do
      row :delivery_date
      row :production_date
      row :roof_built_date
      row :production_inspection_date
      row :production_inspection_passed_date
      row 'Paid Till Now' do
        number_to_currency(production.paid_till_now)
      end
      row :materials_not_used
      row :permit_number
      row :permit_date
      row :permit_department
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    project = f.object

    f.inputs 'Details' do
      f.input :delivery_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :production_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :roof_built_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :production_inspection_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :production_inspection_passed_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :paid_till_now
      f.input :materials_not_used
      f.input :permit_number
      f.input :permit_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :permit_department
    end

    f.submit
  end
end