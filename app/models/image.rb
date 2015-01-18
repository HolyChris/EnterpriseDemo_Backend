class Image < Asset
  has_attached_file :attachment,
                    styles: { small: '100x100>', large: '600x600>' },
                    default_url: '',
                    url: '/images:viewable_type/:id/:style/:basename.:extension',
                    path: '/images/:viewable_type/:id/:style/:basename.:extension',
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' }

  validates_attachment_presence :attachment
  validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\Z/

  # save the w,h of the original image (from which others can be calculated)
  # we need to look at the write-queue for images which have not been saved yet
  after_post_process :find_dimensions

  def find_dimensions
    temporary = attachment.queued_for_write[:original]
    filename = temporary.path unless temporary.nil?
    filename = attachment.path if filename.blank?
    geometry = Paperclip::Geometry.from_file(filename)
    self.attachment_width  = geometry.width
    self.attachment_height = geometry.height
  end
end
