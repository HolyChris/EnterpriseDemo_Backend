class Api::V2::ContractResource < JSONAPI::Resource
  attributes :id, :document_file_name, :document_file_size, :document_content_type, :document_updated_at,
             :signed_at, :site_id, :price, :notes, :special_instructions, :ers_sign_image_file_name,
             :ers_sign_image_file_size, :ers_sign_image_content_type, :ers_sign_image_updated_at,
             :customer_sign_image_file_name, :customer_sign_image_file_size, :customer_sign_image_content_type,
             :customer_sign_image_updated_at, :created_at, :updated_at, :deleted_at, :contract_type, :po_number

end
