ActiveAdmin.register Project, namespace: 'sales_rep' do
  menu false
  belongs_to :site
  actions :show, :edit, :create, :update, :new
  permit_params :priority, :insurance_carrier, :re_roof_material, :color, :material, job_submission_attributes: [
              :id, :po_legacy, :project_id, :shingle_color, :drip_color, :shingle_manufacturer, :shingle_type, :initial_payment,
              :initial_payment_date, :completion_payment, :completion_payment_date, :submitted_at, :work_type, :claim_number,
              :build_type, :deductible, :deductible_paid_date, :roof_work_rcv, :roof_work_acv,
              :roof_type_special_instructions, :hoa_approval_date, :initial_cost_per_sq, :mortgage_company,
              :loan_number, :mortgage_inspection_date, :supplement_required, :supplement_notes, :roof_upgrade_cost,
              :roof_discount, :roof_total, :gutters_rcv, :gutters_upgrade_cost, :gutters_discount, :gutters_total,
              :siding_rcv, :siding_upgrade_cost, :siding_discount, :siding_total, :windows_rcv, :windows_upgrade_cost,
              :windows_discount, :windows_total, :paint_rcv, :paint_upgrade_cost, :paint_discount, :paint_total,
              :hvac_rcv, :hvac_upgrade_cost, :hvac_discount, :hvac_total, :deposit_check_amount,
              :building_code_upgrade_confirmed, :redeck ]

  action_item 'Site', only: [:edit, :new, :show] do
    link_to 'Site', sales_rep_site_url(site)
  end

  action_item 'Contract', only: [:edit, :show] do
    if project.contract.present?
      link_to 'Contract', sales_rep_site_contract_url(project.site, project.contract)
    else
      link_to 'Create Contract', new_sales_rep_site_contract_url(project.site)
    end
  end

  action_item 'Cancel', only: [:edit] do
    link_to 'Cancel', sales_rep_site_project_url(site, project)
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

      row 'Priority' do
        Project::PRIORITY[project.priority]
      end

      row :insurance_carrier
      row :re_roof_material
      row :color

      row 'Material' do
        Project::MATERIAL[project.material]
      end
    end

    if project.job_submission
      panel 'Job Submission' do
        attributes_table_for project.job_submission  do
          row 'PO Legacy' do |js|
            js.po_legacy
          end
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
          row 'Initial Payment' do |js|
            number_to_currency(js.initial_payment)
          end
          row :initial_payment_date, as: :datepicker, input_html: {class: 'date-field'}
          row 'Completion Payment' do |js|
            number_to_currency(js.completion_payment)
          end
          row :completion_payment_date, as: :datepicker, input_html: {class: 'date-field'}
          row :submitted_at, as: :datepicker, input_html: {class: 'date-field'}
          row 'Type of Work to be Completed' do |js|
            JobSubmission::WORK_TYPE[js.work_type]
          end
          row :claim_number
          row :build_type
          row 'Deductible' do |js|
            number_to_currency(js.deductible)
          end
          row :deductible_paid_date
          row 'Roof Work RCV' do |js|
            number_to_currency(js.roof_work_rcv)
          end
          row 'Roof Work ACV' do |js|
            number_to_currency(js.roof_work_acv)
          end
          row :roof_type_special_instructions
          row :hoa_approval_date
          row 'Initial Cost per SQ' do |js|
            number_to_currency(js.initial_cost_per_sq)
          end
          row :mortgage_company
          row :loan_number
          row :mortgage_inspection_date
          row :supplement_required
          row :supplement_notes
          row 'Deposit Check Recieved' do |js|
            number_to_currency(js.deposit_check_amount)
          end
          row :building_code_upgrade_confirmed
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
          row 'Roof Total' do |js|
            number_to_currency(js.roof_total)
          end
        end
      end

      panel 'Gutter Details' do
        attributes_table_for project.job_submission  do
          row 'Gutters RCV' do |js|
            number_to_currency(js.gutters_rcv)
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
      f.input :material, as: :select, collection: Project::MATERIAL.collect {|k,v| [v, k]}
      f.input :insurance_carrier
      f.input :re_roof_material, label: 'Re-Roof Material'
      f.input :color, as: :string
    end

    project.job_submission || project.build_job_submission
    f.fields_for :job_submission do |jsf|
      jsf.inputs 'Job Submission' do
        jsf.input :po_legacy, label: 'PO Legacy'
        jsf.input :shingle_color, as: :select, collection: JobSubmission::SHINGLE_COLOR.collect {|k,v| [v, k]}
        jsf.input :drip_color, as: :select, collection: JobSubmission::DRIP_COLOR.collect {|k,v| [v, k]}
        jsf.input :shingle_manufacturer, as: :select, collection: JobSubmission::SHINGLE_MANUFACTURER.collect {|k,v| [v, k]}
        jsf.input :shingle_type, as: :select, collection: JobSubmission::SHINGLE_TYPE.collect {|k,v| [v, k]}
        jsf.input :initial_payment
        jsf.input :initial_payment_date, as: :datepicker, input_html: {class: 'date-field'}
        jsf.input :completion_payment
        jsf.input :completion_payment_date, as: :datepicker, input_html: {class: 'date-field'}
        jsf.input :submitted_at, as: :datepicker, input_html: {class: 'date-field'}
        jsf.input :work_type, as: :select, collection: JobSubmission::WORK_TYPE.collect {|k,v| [v, k]}
        jsf.input :claim_number
        jsf.input :build_type
        jsf.input :deductible
        jsf.input :deductible_paid_date, as: :datepicker, input_html: {class: 'date-field'}
        jsf.input :roof_work_rcv
        jsf.input :roof_work_acv
        jsf.input :roof_type_special_instructions
        jsf.input :hoa_approval_date, as: :datepicker, input_html: {class: 'date-field'}
        jsf.input :initial_cost_per_sq
        jsf.input :mortgage_company
        jsf.input :loan_number
        jsf.input :mortgage_inspection_date, as: :datepicker, input_html: {class: 'date-field'}
        jsf.input :supplement_required
        jsf.input :supplement_notes
        jsf.input :deposit_check_amount
        jsf.input :building_code_upgrade_confirmed
        jsf.input :redeck
        jsf.input :roof_upgrade_cost
        jsf.input :roof_discount
        jsf.input :roof_total
        jsf.input :gutters_rcv, label: 'Gutters RCV'
        jsf.input :gutters_upgrade_cost
        jsf.input :gutters_discount
        jsf.input :gutters_total
        jsf.input :siding_rcv, label: 'Siding RCV'
        jsf.input :siding_upgrade_cost
        jsf.input :siding_discount
        jsf.input :siding_total
        jsf.input :windows_rcv, label: 'Windows RCV'
        jsf.input :windows_upgrade_cost
        jsf.input :windows_discount
        jsf.input :windows_total
        jsf.input :paint_rcv, label: 'Paint RCV'
        jsf.input :paint_upgrade_cost
        jsf.input :paint_discount
        jsf.input :paint_total
        jsf.input :hvac_rcv, label: 'HVAC RCV'
        jsf.input :hvac_upgrade_cost
        jsf.input :hvac_discount
        jsf.input :hvac_total
      end
    end

    f.submit
  end
end