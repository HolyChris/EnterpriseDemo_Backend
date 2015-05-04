object :@contract

attributes :id, :po_number, :signed_at, :notes, :special_instructions

node(:contract_type) {|contract| contract.type_string}
node(:price) { |contract| number_to_currency(contract.price) }
node(:document_url) {|contract| contract.document.url}
node(:ers_sign_image_url) {|contract| contract.ers_sign_image.url}
node(:customer_sign_image_url) {|contract| contract.customer_sign_image.url}

child(:work_types) do
  attributes :id, :name
end

child(:site) do
  attributes :id, :name, :source_info, :damage, :contact_name, :contact_phone

  node(:bill_addr_same_as_addr) { |site| site.bill_addr_same_as_addr }
  node(:stage) {|site| site.stage_string}
  node(:po_number) {|site| site.po_number}
  node(:source) {|site| site.source_string}
  node(:status) {|site| site.status_string}
end