class Attachment < ActiveRecord::Base
  # include DelegateBelongsTo
  include Rails.application.routes.url_helpers
  attr_accessor
  belongs_to :asset

  has_attached_file :file,
                    styles: lambda { |a| a.instance.file.content_type  =~ /\Aimage\/.*\Z/ ? {thumb: '100x100>'} : {} },
                    default_url: '',
                    url: "/attachments/:id/:style_:basename.:extension",
                    path: "/attachments/:id/:style_:basename.:extension",
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' }


  validates_attachment_presence :file
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/, if: :image?
  validates_attachment_content_type :file, content_type: ['application/pdf', 'application/msword',
                                                          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                                                          'image/jpeg', 'image/jpg', 'image/png', 'image/gif',
                                                          'application/vnd.oasis.opendocument.spreadsheet',
                                                          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                                                          'application/vnd.ms-excel', 'text/csv', 'text/plain'], if: :document?

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
    asset = self.asset
    site = asset.viewable
    {
      "name" => file_file_name,
      "size" => file_file_size,
      "url" => file.url,
      "thumbnail_url" => file.url,
      "delete_url" => site_asset_path(site_id: site.id,:id => asset.id),
      "update_url" => site_asset_path(site_id: site.id,:id => asset.id),
      "delete_type" => "DELETE",
      "content_type" => file_content_type,
      "title" => asset.title,
      "notes" => asset.notes,
      "stage" => asset.stage,
      "doc_type" => asset.doc_type,
      "type" => file_content_type
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
