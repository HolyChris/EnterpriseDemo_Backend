ActiveAdmin.register Contract do
  menu false
  belongs_to :site
  actions :show, :edit, :create, :update, :new
  permit_params :document, :price, :notes, :special_instructions, :contract_type,
                :ers_sign_image, :customer_sign_image, :signed_at, work_type_ids: []

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

      row 'Attachment' do
        link_to contract.document_file_name, contract.document.url, target: '_blank'
      end

      row :signed_at

      row 'Type of Contract' do
        contract.type_string
      end

      row 'Type of work to be completed' do
        contract.work_type_names
      end

      row 'Price' do
        number_to_currency(contract.price)
      end

      row :notes
      row :special_instructions

      # row 'ERS Sign' do
      #   if contract.ers_sign_image_file_name?
      #     link_to contract.ers_sign_image_file_name, contract.ers_sign_image.url, target: '_blank'
      #   else
      #     '-'
      #   end
      # end

      # row 'Customer Sign' do
      #   if contract.customer_sign_image_file_name?
      #     link_to contract.customer_sign_image_file_name, contract.customer_sign_image.url, target: '_blank'
      #   else
      #     '-'
      #   end
      # end
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
      f.input :contract_type, as: :select, collection: Contract::TYPE.collect{|k,v| [v, k]}, label: 'Type of Contract'

      li class: 'input' do
        f.label :type_of_work_to_be_completed, class: 'label'

        WorkType.all.each do |work_type|
          html = []
          span do
            html << check_box_tag("contract[work_type_ids][]", work_type.id, contract.has_work_type?(work_type))
            html << work_type.name
            html << '&nbsp;&nbsp;&nbsp;&nbsp;'
            html.join(' ').html_safe
          end
        end
      end

      f.input :price
      f.input :notes
      f.input :special_instructions
    end

    # f.inputs 'Signatures' do
    #   f.input :ers_sign_image, as: :file
    #   f.input :customer_sign_image, as: :file
    # end

    f.submit
  end
end