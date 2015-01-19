object :@contract

attributes :id, :po_number, :signed_at, :notes, :special_instructions, :construction_start_at, :construction_end_at, :construction_payment_at

node(:price) { |contract| number_to_currency(contract.price) }
node(:paid_till_now) { |contract| number_to_currency(contract.paid_till_now) }
node(:document_url) {|contract| contract.document.url}
node(:ers_sign_image_url) {|contract| contract.ers_sign_image.url}
node(:customer_sign_image_url) {|contract| contract.customer_sign_image.url}

child(:site) do
  attributes :id, :name, :damage, :roof_built_at, :insurance_company, :claim_number, :mortgage_company, :loan_tracking_number

  node(:source) {|site| Site::SOURCE[site.source]}
  node(:status) {|site| Site::STATUS[site.status]}
end