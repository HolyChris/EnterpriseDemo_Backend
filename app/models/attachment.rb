class Attachment < ActiveRecord::Base
  # include DelegateBelongsTo
  attr_accessor
  belongs_to :asset

  has_attached_file :file,
                    default_url: '',
                    url: "/attachments/:id/:style_:basename.:extension",
                    path: "/attachments/:id/:style_:basename.:extension",
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' }

  validates_attachment_presence :file
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/, if: :image?
  validates_attachment_content_type :file, content_type: ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'image/jpeg', 'image/jpg', 'image/png', 'image/gif'], if: :document?

  validates :asset, presence: true
  validate :no_attachment_errors

  # save the w,h of the original image (from which others can be calculated)
  # we need to look at the write-queue for images which have not been saved yet
  after_post_process :find_dimensions, if: :image?

  def find_dimensions
    temporary = file.queued_for_write[:original]
    filename = temporary.path unless temporary.nil?
    filename = file.path if filename.blank?
    geometry = Paperclip::Geometry.from_file(filename)
    self.file_width  = geometry.width
    self.file_height = geometry.height
  end

  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE" 
    }
  end

  def image?
    asset.try(:image?)
  end

  def document?
    asset.try(:document?)
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