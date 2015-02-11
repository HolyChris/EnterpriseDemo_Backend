class Document < Asset
  validates :doc_type, presence: true
end
