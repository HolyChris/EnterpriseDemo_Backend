class Asset < ActiveRecord::Base
  audited

  belongs_to :viewable, polymorphic: true, touch: true
  SUBCLASS = ['Document', 'Image']
  DOC_TYPE = { 1 => 'Billing Reference Document', 2 => 'Completion Payment Check', 3 => 'Customer Invoice',
              4 => 'Deductive Check', 5 => 'EagleView', 6 => 'HOA Approval Document', 7 => 'Initial Payment Check',
              8 => 'Insurance scope document', 9 => 'Material List', 10 => 'Supplement Documentation',
              11 => 'Trade work Bid', 12 => 'Xactmate', 13 => 'Other' }

  validates :type, :doc_type, presence: true
  validate :no_attachment_errors

  scope :images, -> { where(type: 'Image') }
  scope :docs, -> { where(type: 'Document') }

  before_validation :set_stage, unless: :stage?
  before_validation :set_title, unless: :title?

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

  private
    def set_title
      if doc_type != DOC_TYPE.key('Other')
        self.title = DOC_TYPE[doc_type]
      end
    end

    def set_stage
      if viewable.is_a?(Site)
        self.stage = Site::STAGE[viewable.stage.try(:to_sym) || :lead]
      end
    end
end
