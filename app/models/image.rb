class Image < Asset
  has_many :attachments, foreign_key: :asset_id, dependent: :destroy
  validates :attachments, presence: true
  accepts_nested_attributes_for :attachments
end
