object :@site


attributes :id, :name, :source_info, :damage, :contact_name, :contact_phone

node(:bill_addr_same_as_addr) { |site| site.bill_addr_same_as_addr }
node(:stage) {|site| site.stage_string}
node(:po_number) {|site| site.po_number}
node(:source) {|site| site.source_string}
node(:status) {|site| site.status_string}

child(:customer) do
  attributes :id, :email, :firstname, :lastname, :spouse, :business_name, :other_business_info

  child(:phone_numbers) do
    attributes :id, :number, :primary, :num_type, :num_type_string
  end
end

child(:billing) do
  attributes :id, :initial_payment, :initial_payment_date,
             :customer_invoice_notes,  :invoice_sent_to_customer_method,
             :completion_payment_date, :mortgage_process_notes, :mortgage_check_location, :deductible_paid_date,
             :settled_rcv, :settled_rcv_date, :settled_scope_paperwork_notes, :final_check_received_amount,
             :check_released_date, :final_check_received_date, :completion_payment

  node(:ready_for_billing_at) {|billing| billing.ready_for_billing_at.try(:iso8601) }
  node(:final_invoice_submitted_at) {|billing| billing.final_invoice_submitted_at.try(:iso8601) }
  node(:invoice_send_to_manager_at) {|billing| billing.invoice_send_to_manager_at.try(:iso8601) }
  node(:invoice_sent_to_customer_at) {|billing| billing.invoice_sent_to_customer_at.try(:iso8601) }
end

child(:production) do
  attributes :id
end

child(:contract) do
  attributes :id, :po_number, :notes, :special_instructions

  node(:signed_at) {|contract| contract.signed_at.try(:iso8601) }
  node(:contract_type) {|contract| contract.type_string}
  node(:price) { |contract| number_to_currency(contract.price) }
  node(:document_url) {|contract| contract.document.url}
  node(:ers_sign_image_url) {|contract| contract.ers_sign_image.url}
  node(:customer_sign_image_url) {|contract| contract.customer_sign_image.url}

  child(:work_types) do
    attributes :id, :name
  end
end

child(:address) do
  attributes :id, :address1, :address2, :city, :zipcode
  child(:state) do
    attributes :id, :name
  end
end

child(:bill_address) do
  attributes :id, :address1, :address2, :city, :zipcode
  child(:state) do
    attributes :id, :name
  end
end

child(:appointments) do
  attributes :id, :notes
  node(:scheduled_at) {|appointment| appointment.scheduled_at.try(:iso8601) }
  node(:outcome) {|appointment| appointment.outcome_string}

  child(:assigned_to) do
    attributes :id, :fullname, :email
  end

  child(:created_by) do
    attributes :id, :fullname, :email
  end

  child(:follow_ups) do
    attributes :id, :notes
    node(:scheduled_at) {|follow_up| follow_up.scheduled_at.try(:iso8601) }
  end
end

child :assets do
  attributes :id, :title, :type, :notes
  node(:doc_type) { |asset| Asset::DOC_TYPE[asset.doc_type] }
  node(:stage) { |asset| Site::STAGE_MAPPING[Site::STAGE.key(asset.stage)] }
  child(:attachments) do
    attributes :id
    node(:file_name) { |attachment| attachment.file_file_name }
    node(:url) { |attachment| attachment.file.url }
  end
end

child :managers do
  attributes :id, :email, :firstname, :lastname
  node(:primary) {|manager| manager.site_managers.find_by(site: @site).try(:primary)  }
end
