class Attachment < ActiveRecord::Base
  include DelegateBelongsTo

  belongs_to :asset

  has_attached_file :file,
                    styles: { small: '100x100>', large: '600x600>' },
                    default_url: '',
                    url: '/images:viewable_type/:id/:style/:basename.:extension',
                    path: '/images/:viewable_type/:id/:style/:basename.:extension',
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' }, if: :image?

  has_attached_file :attachment,
                    default_url: '',
                    url: "/docs/:viewable_type/:id/:basename.:extension",
                    path: '/docs/:viewable_type/:id/:basename.:extension', if: :document?

  validates_attachment_presence :file
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/, if: :image?
  validates_attachment_content_type :file, content_type: ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'image/jpeg', 'image/jpg', 'image/png', 'image/gif'], if: :document?

  validates :asset, presence: true
  validate :no_attachment_errors

  # save the w,h of the original image (from which others can be calculated)
  # we need to look at the write-queue for images which have not been saved yet
  after_post_process :find_dimensions
  delegate_belongs_to :asset, :image?, :document?

  Paperclip.interpolates('viewable_type') do |attachment, style|
    attachment.instance.asset.viewable_type.downcase
  end

  def find_dimensions
    temporary = file.queued_for_write[:original]
    filename = temporary.path unless temporary.nil?
    filename = file.path if filename.blank?
    geometry = Paperclip::Geometry.from_file(filename)
    self.file_width  = geometry.width
    self.file_height = geometry.height
  end

  # if there are errors from the plugin, then add a more meaningful message
  def no_attachment_errors
    unless file.errors.empty?
      # uncomment this to get rid of the less-than-useful interrim messages
      # errors.clear
      errors.add :file, "Paperclip returned errors for file '#{file_file_name}' - check ImageMagick installation or image source file."
      false
    end
  end
end