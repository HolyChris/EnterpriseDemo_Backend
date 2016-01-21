class Api::V2::CustomerResource < JSONAPI::Resource

  attributes :id, :firstname, :lastname, :email, :spouse, :business_name,
              :other_business_info, :created_at, :updated_at, :deleted_at,
              :page_token

end
