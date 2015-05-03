ActiveAdmin.register Billing do
  menu false
  belongs_to :site
  actions :show, :edit, :create, :update, :new
  permit_params :ready_for_billing_at, :initial_payment, :initial_payment_date, :final_invoice_submitted_at,
                :customer_invoice_notes, :invoice_send_to_manager_at, :invoice_sent_to_customer_method,
                :completion_payment, :completion_payment_date, :mortgage_process_notes, :mortgage_check_location,
                :deductible_paid_date, :settled_rcv, :settled_rcv_date, :settled_scope_paperwork_notes,
                :final_check_received_amount, :check_released_date, :final_check_received_date, :invoice_sent_to_customer_at

  action_item 'Site', only: [:edit, :new, :show] do
    link_to 'Site', admin_site_url(site)
  end

  action_item 'Contract', only: [:edit, :new, :show] do
    link_to 'Contract', admin_site_contract_url(site, billing.contract)
  end

  action_item 'Project', only: [:edit, :new, :show] do
    link_to 'Project', admin_site_project_url(site, billing.project)
  end

  action_item 'Production', only: [:edit, :new, :show] do
    link_to 'Production', admin_site_production_url(site, billing.production)
  end

  action_item 'Docs', only: [:show, :edit, :new] do
    link_to 'Docs', admin_site_documents_url(billing.site)
  end

  action_item 'Images', only: [:show, :edit, :new] do
    link_to 'Images', admin_site_images_url(billing.site)
  end

  action_item 'Cancel', only: [:edit] do
    link_to 'Cancel', admin_site_billing_url(site, billing)
  end

  controller do
    def scoped_collection
      if @site = Site.find_by(id: params[:site_id])
        Billing.where(site_id: @site.id)
      end
    end
  end

  show do
    panel 'Location Billing Info' do
      attributes_table_for billing do
        row 'Project Received in Billing' do
          billing.ready_for_billing_at
        end
        row 'Initial Payment' do
          number_to_currency(billing.initial_payment)
        end
        row :initial_payment_date
        row :final_invoice_submitted_at
        row :customer_invoice_notes
        row 'Invoice sent to Project Manager (Date)' do
          billing.invoice_send_to_manager_at
        end
        row :invoice_sent_to_customer_method
        row 'Completion Payment' do
          number_to_currency(billing.completion_payment)
        end
        row :completion_payment_date
      end
    end

    panel 'Insurance Info' do
      attributes_table_for billing do
        row :mortgage_process_notes
        row :mortgage_check_location
        row :deductible_paid_date
        row 'Settled RCV' do
          number_to_currency(billing.settled_rcv)
        end
        row 'Settled RCV Date' do
          billing.settled_rcv_date
        end
        row :settled_scope_paperwork_notes
        row 'Final Check Received Amount' do
          number_to_currency(billing.final_check_received_amount)
        end
        row :check_released_date
        row :final_check_received_date
        row :invoice_sent_to_customer_at
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    billing = f.object

    f.inputs 'Location Billing Info' do
      f.input :ready_for_billing_at, as: :datepicker, input_html: {class: 'date-field'}, label: 'Project Received in Billing'
      f.input :initial_payment
      f.input :initial_payment_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :final_invoice_submitted_at, as: :datepicker, input_html: {class: 'date-field'}
      f.input :customer_invoice_notes
      f.input :invoice_send_to_manager_at, as: :datepicker, input_html: {class: 'date-field'}, label: 'Invoice sent to Project Manager (Date)'
      f.input :invoice_sent_to_customer_method
      f.input :completion_payment
      f.input :completion_payment_date, as: :datepicker, input_html: {class: 'date-field'}
    end

    f.inputs 'Insurance Info' do
      f.input :mortgage_process_notes
      f.input :mortgage_check_location
      f.input :deductible_paid_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :settled_rcv, label: 'Settled RCV'
      f.input :settled_rcv_date, as: :datepicker, input_html: {class: 'date-field'}, label: 'Settled RCV Date'
      f.input :settled_scope_paperwork_notes
      f.input :final_check_received_amount
      f.input :check_released_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :final_check_received_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :invoice_sent_to_customer_at, as: :datepicker, input_html: {class: 'date-field'}
    end

    f.submit
  end
end