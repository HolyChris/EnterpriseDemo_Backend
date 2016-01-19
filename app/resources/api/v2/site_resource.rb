class Api::V2::SiteResource < JSONAPI::Resource
  attributes :id, :name, :address_id, :customer_id, :stage, :source, :damage, :status,
             :created_at, :updated_at, :deleted_at, :contact_name, :contact_phone,
             :bill_address_id, :source_info, :cover_photo_file_name, :cover_photo_content_type,
             :cover_photo_file_size, :cover_photo_updated_at

  has_many :assets

  has_one :customer
  has_one :address

  filters :stage

  def self.apply_filter(records, filter, value, options)
    return records unless value.any?
    filter = filter.to_sym

    if [:stage].include? filter
      records = records.send(filter, value.first)
    end

    records
  end
end
