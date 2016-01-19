class Api::V2::AddressResource < JSONAPI::Resource
  attributes :id, :address1, :address2, :city, :zipcode, :phone, :state_name,
             :alt_phone, :company, :state_id, :country_id, :customer_id,
             :created_at, :updated_at, :deleted_at
end
