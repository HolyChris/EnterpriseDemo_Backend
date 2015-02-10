class Document < Asset
  has_one :attachment, foreign_key: :asset_id, dependent: :destroy
  validates :doc_type, :attachment, presence: true
  accepts_nested_attributes_for :attachment
end
