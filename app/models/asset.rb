class Asset < ActiveRecord::Base
  audited

  belongs_to :viewable, polymorphic: true, touch: true
  has_many :attachments, dependent: :destroy, inverse_of: :asset
  accepts_nested_attributes_for :attachments, allow_destroy: true

  SUBCLASS = ['Document', 'Image']
  DOC_TYPE = { 1 => 'Billing Reference Document', 2 => 'Completion Payment Check', 3 => 'Customer Invoice',
              4 => 'Deductible Check', 5 => 'EagleView', 6 => 'HOA Approval Document', 7 => 'Initial Payment Check',
              8 => 'Insurance scope document', 9 => 'Material List', 10 => 'Supplement Documentation',
              11 => 'Trade work Bid', 12 => 'Xactimate', 13 => 'Other' }

  validates :type, :viewable, :attachments, presence: true

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
