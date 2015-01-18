class Document < Asset
  has_attached_file :attachment,
                    default_url: '',
                    url: "/docs/:viewable_type/:id/:basename.:extension",
                    path: '/docs/:viewable_type/:id/:basename.:extension'

  validates_attachment_presence :attachment
  validates_attachment_content_type :attachment, content_type: ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']
end
