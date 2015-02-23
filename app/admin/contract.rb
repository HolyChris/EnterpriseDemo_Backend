ActiveAdmin.register Contract do
  menu false
  belongs_to :site
  actions :show, :edit, :create, :update, :new
  permit_params :document, :price, :paid_till_now, :notes, :special_instructions,
                :ers_sign_image, :customer_sign_image, :signed_at, :construction_start_at_date,
                :construction_start_at_time_hour, :construction_start_at_time_minute,
                :construction_end_at_date, :construction_end_at_time_hour, :construction_end_at_time_minute,
                :construction_payment_at_date, :construction_payment_at_time_hour, :construction_payment_at_time_minute

  action_item 'Site', only: [:edit, :new, :show] do
    link_to 'Site', admin_site_url(site)
  end

  action_item 'Project', only: [:edit, :show] do
    if contract.project.present?
      link_to 'Project', admin_site_project_url(contract.site, contract.project)
    else
      link_to 'Create Project', new_admin_site_project_url(contract.site)
    end
  end

  action_item 'Cancel', only: [:edit] do
    link_to 'Cancel', admin_site_contract_url(site, contract)
  end

  controller do
    def scoped_collection
      if @site = Site.find_by(id: params[:site_id])
        Contract.where(site_id: @site.id)
      end
    end
  end

  show do
    attributes_table do
      row 'PO#' do
        contract.po_number
      end

      row 'Attachment' do |contract|
        link_to contract.document_file_name, contract.document.url, target: '_blank'
      end

      row :signed_at

      row 'Price' do
        number_to_currency(contract.price)
      end

      row 'Paid Till Now' do
        number_to_currency(contract.paid_till_now)
      end

      row :construction_start_at
      row :construction_end_at
      row :construction_payment_at
      row :notes
      row :special_instructions

      row 'ERS Sign' do |contract|
        if contract.ers_sign_image_file_name?
          link_to contract.ers_sign_image_file_name, contract.ers_sign_image.url, target: '_blank'
        else
          '-'
        end
      end

      row 'Customer Sign' do |contract|
        if contract.customer_sign_image_file_name?
          link_to contract.customer_sign_image_file_name, contract.customer_sign_image.url, target: '_blank'
        else
          '-'
        end
      end
    end
  end

  form(html: { multipart: true }) do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Details' do
      if f.object.persisted?
        f.input :po_number, input_html: { disabled: true }, label: 'PO#'
      end
      f.input :document, as: :file, required: true
      f.input :signed_at, as: :datepicker, input_html: { class: 'date-field' }
      f.input :price
      f.input :paid_till_now
      f.input :construction_start_at, as: :just_datetime_picker, input_html: { class: 'date-field' }
      f.input :construction_end_at, as: :just_datetime_picker, input_html: { class: 'date-field' }
      f.input :construction_payment_at, as: :just_datetime_picker, input_html: { class: 'date-field' }
      f.input :notes
      f.input :special_instructions
    end

    f.inputs 'Signatures' do
      f.input :ers_sign_image, as: :file
      f.input :customer_sign_image, as: :file
    end

    f.submit
  end
end