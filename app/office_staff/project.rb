ActiveAdmin.register Project, namespace: 'office_staff' do
  menu false
  belongs_to :site
  actions :show, :edit, :create, :update, :new
  permit_params :priority, :existing_roof_material, :code_coverage_confirmed, :hoa_approval_date, :last_roof_built_date,
              :po_legacy, insurance_and_mortgage_info_attributes: [:id, :project_id, :insurance_carrier, :claim_number, :deductible,
              :loan_tracking_number, :mortgage_company], job_submission_attributes: [ :id, :project_id, :shingle_color,
              :drip_color, :shingle_manufacturer, :shingle_type, :work_type, :roof_work_rcv, :roof_work_acv,
              :roof_type_special_instructions, :initial_cost_per_sq, :roof_upgrade_cost, :roof_discount, :gutters_rcv,
              :gutters_acv, :gutters_upgrade_cost, :gutters_discount, :gutters_total, :siding_rcv, :siding_acv,
              :siding_upgrade_cost, :siding_discount, :siding_total, :windows_rcv, :windows_acv, :windows_upgrade_cost,
              :windows_discount, :windows_total, :paint_rcv, :paint_acv, :paint_upgrade_cost, :paint_discount, :paint_total,
              :hvac_rcv, :hvac_acv, :hvac_upgrade_cost, :hvac_discount, :hvac_total, :redeck ]

  action_item 'Site', only: [:edit, :new, :show] do
    link_to 'Site', office_staff_site_url(site)
  end

  action_item 'Contract', only: [:edit, :show] do
    link_to 'Contract', office_staff_site_contract_url(project.site, project.contract)
  end

  action_item 'Production', only: [:edit, :show] do
    if project.production.present?
      link_to 'Production', office_staff_site_production_url(project.site, project.production)
    else
      link_to 'Create Production', new_office_staff_site_production_url(project.site)
    end
  end

  action_item 'Billing', only: [:show, :edit] do
    if project.production.present?
      if project.billing.present?
        link_to 'Billing', office_staff_site_billing_url(project.site, project.billing)
      else
        link_to 'Create Billing', new_office_staff_site_billing_url(project.site)
      end
    end
  end

  action_item 'Docs', only: [:show, :edit] do
    link_to 'Docs', office_staff_site_documents_url(project.site)
  end

  action_item 'Images', only: [:show, :edit] do
    link_to 'Images', office_staff_site_images_url(project.site)
  end

  action_item 'Cancel', only: [:edit] do
    link_to 'Cancel', office_staff_site_project_url(site, project)
  end

  controller do
    def scoped_collection
      if @site = Site.find_by(id: params[:site_id])
        Project.where(site_id: @site.id)
      end
    end
  end

  show do
    attributes_table do
      row 'PO#' do
        project.po_number
      end

      row 'PO Legacy' do
        project.po_legacy
      end

      row :code_coverage_confirmed

      row 'Priority' do
        Project::PRIORITY[project.priority]
      end

      row :existing_roof_material
      row :hoa_approval_date
      row :last_roof_built_date
    end

    if project.insurance_and_mortgage_info
      panel 'Insurance And Mortgage Info' do
        attributes_table_for project.insurance_and_mortgage_info  do
          row :insurance_carrier
          row :claim_number
          row 'Deductible' do |iami|
            number_to_currency(iami.deductible)
          end
          row :mortgage_company
          row :loan_tracking_number
        end
      end
    end

    if project.job_submission
      panel 'Job Submission' do
        attributes_table_for project.job_submission  do
          row 'Shingle Color' do |js|
            JobSubmission::SHINGLE_COLOR[js.shingle_color]
          end
          row 'Drip Color' do |js|
            JobSubmission::DRIP_COLOR[js.drip_color]
          end
          row 'Shingle Manufacturer' do |js|
            JobSubmission::SHINGLE_MANUFACTURER[js.shingle_manufacturer]
          end
          row 'Shingle Type' do |js|
            JobSubmission::SHINGLE_TYPE[js.shingle_type]
          end
          row 'Type of Work to be Completed' do |js|
            JobSubmission::WORK_TYPE[js.work_type]
          end
          row 'Roof Work RCV' do |js|
            number_to_currency(js.roof_work_rcv)
          end
          row 'Roof Work ACV' do |js|
            number_to_currency(js.roof_work_acv)
          end
          row :roof_type_special_instructions
          row 'Initial Cost per SQ' do |js|
            number_to_currency(js.initial_cost_per_sq)
          end
          row :redeck
        end
      end

      panel 'Roof Details' do
        attributes_table_for project.job_submission  do
          row 'Roof Upgrade Cost' do |js|
            number_to_currency(js.roof_upgrade_cost)
          end
          row 'Roof Discount' do |js|
            number_to_currency(js.roof_discount)
          end
        end
      end

      panel 'Gutter Details' do
        attributes_table_for project.job_submission  do
          row 'Gutters RCV' do |js|
            number_to_currency(js.gutters_rcv)
          end
          row 'Gutters ACV' do |js|
            number_to_currency(js.gutters_acv)
          end
          row 'Gutters Upgrade Cost' do |js|
            number_to_currency(js.gutters_upgrade_cost)
          end
          row 'Gutters Discount' do |js|
            number_to_currency(js.gutters_discount)
          end
          row 'Gutters Total' do |js|
            number_to_currency(js.gutters_total)
          end
        end
      end

      panel 'Siding Details' do
        attributes_table_for project.job_submission  do
          row 'Siding RCV' do |js|
            number_to_currency(js.siding_rcv)
          end
          row 'Siding ACV' do |js|
            number_to_currency(js.siding_acv)
          end
          row 'Siding Upgrade Cost' do |js|
            number_to_currency(js.siding_upgrade_cost)
          end
          row 'Siding Discount' do |js|
            number_to_currency(js.siding_discount)
          end
          row 'Siding Total' do |js|
            number_to_currency(js.siding_total)
          end
        end
      end

      panel 'Window Details' do
        attributes_table_for project.job_submission  do
          row 'Windows RCV' do |js|
            number_to_currency(js.windows_rcv)
          end
          row 'Windows ACV' do |js|
            number_to_currency(js.windows_acv)
          end
          row 'Windows Upgrade Cost' do |js|
            number_to_currency(js.windows_upgrade_cost)
          end
          row 'Windows Discount' do |js|
            number_to_currency(js.windows_discount)
          end
          row 'Windows Total' do |js|
            number_to_currency(js.windows_total)
          end
        end
      end

      panel 'Paint Details' do
        attributes_table_for project.job_submission  do
          row 'Paint RCV' do |js|
            number_to_currency(js.paint_rcv)
          end
          row 'Paint ACV' do |js|
            number_to_currency(js.paint_acv)
          end
          row 'Paint Upgrade Cost' do |js|
            number_to_currency(js.paint_upgrade_cost)
          end
          row 'Paint Discount' do |js|
            number_to_currency(js.paint_discount)
          end
          row 'Paint Total' do |js|
            number_to_currency(js.paint_total)
          end
        end
      end

      panel 'HVAC Details' do
        attributes_table_for project.job_submission  do
          row 'HVAC RCV' do |js|
            number_to_currency(js.hvac_rcv)
          end
          row 'HVAC ACV' do |js|
            number_to_currency(js.hvac_acv)
          end
          row 'HVAC Upgrade Cost' do |js|
            number_to_currency(js.hvac_upgrade_cost)
          end
          row 'HVAC Discount' do |js|
            number_to_currency(js.hvac_discount)
          end
          row 'HVAC Total' do |js|
            number_to_currency(js.hvac_total)
          end
        end
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    project = f.object

    f.inputs 'Details' do
      f.input :priority, as: :select, collection: Project::PRIORITY.collect {|k,v| [v, k]}
      f.input :code_coverage_confirmed
      f.input :existing_roof_material
      f.input :last_roof_built_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :po_legacy, label: 'PO Legacy'
      f.input :hoa_approval_date, as: :datepicker, input_html: {class: 'date-field'}
    end

    project.insurance_and_mortgage_info || project.build_insurance_and_mortgage_info
    f.fields_for :insurance_and_mortgage_info do |iami|
      iami.inputs 'Insurance And Mortgage Info' do
        iami.input :insurance_carrier
        iami.input :claim_number
        iami.input :deductible
        iami.input :loan_tracking_number
        iami.input :mortgage_company
      end
    end

    project.job_submission || project.build_job_submission
    f.fields_for :job_submission do |jsf|
      jsf.inputs 'Job Submission' do
        jsf.input :shingle_color, as: :select, collection: JobSubmission::SHINGLE_COLOR.collect {|k,v| [v, k]}
        jsf.input :drip_color, as: :select, collection: JobSubmission::DRIP_COLOR.collect {|k,v| [v, k]}
        jsf.input :shingle_manufacturer, as: :select, collection: JobSubmission::SHINGLE_MANUFACTURER.collect {|k,v| [v, k]}
        jsf.input :shingle_type, as: :select, collection: JobSubmission::SHINGLE_TYPE.collect {|k,v| [v, k]}
        jsf.input :work_type, as: :select, collection: JobSubmission::WORK_TYPE.collect {|k,v| [v, k]}
        jsf.input :roof_work_rcv
        jsf.input :roof_work_acv
        jsf.input :roof_type_special_instructions
        jsf.input :initial_cost_per_sq
        jsf.input :redeck
        jsf.input :roof_upgrade_cost
        jsf.input :roof_discount
        jsf.input :gutters_rcv, label: 'Gutters RCV'
        jsf.input :gutters_acv, label: 'Gutters ACV'
        jsf.input :gutters_upgrade_cost
        jsf.input :gutters_discount
        jsf.input :gutters_total
        jsf.input :siding_rcv, label: 'Siding RCV'
        jsf.input :siding_acv, label: 'Siding ACV'
        jsf.input :siding_upgrade_cost
        jsf.input :siding_discount
        jsf.input :siding_total
        jsf.input :windows_rcv, label: 'Windows RCV'
        jsf.input :windows_acv, label: 'Windows ACV'
        jsf.input :windows_upgrade_cost
        jsf.input :windows_discount
        jsf.input :windows_total
        jsf.input :paint_rcv, label: 'Paint RCV'
        jsf.input :paint_acv, label: 'Paint ACV'
        jsf.input :paint_upgrade_cost
        jsf.input :paint_discount
        jsf.input :paint_total
        jsf.input :hvac_rcv, label: 'HVAC RCV'
        jsf.input :hvac_acv, label: 'HVAC ACV'
        jsf.input :hvac_upgrade_cost
        jsf.input :hvac_discount
        jsf.input :hvac_total
      end
    end

    f.submit
  end
end