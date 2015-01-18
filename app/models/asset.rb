class Asset < ActiveRecord::Base
  audited

  belongs_to :viewable, polymorphic: true, touch: true
  SUBCLASS = ['Document', 'Image']

  validates :type, presence: true
  validate :no_attachment_errors

  scope :images, -> { where(type: 'Image') }
  scope :docs, -> { where(type: 'Document') }

  def document?
    is_a?(Document)
  end

  def image?
    is_a?(Image)
  end

  # if there are errors from the plugin, then add a more meaningful message
  def no_attachment_errors
    unless attachment.errors.empty?
      # uncomment this to get rid of the less-than-useful interrim messages
      # errors.clear
      errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
      false
    end
  end

  Paperclip.interpolates('viewable_type') do |attachment, style|
    attachment.instance.viewable_type.downcase
  end
end
