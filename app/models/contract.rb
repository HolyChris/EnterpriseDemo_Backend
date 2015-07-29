class Contract < ActiveRecord::Base
  audited
  acts_as_paranoid

  just_define_datetime_picker :signed_at

  TYPE = { 1 => 'Cash', 2 => 'Insurance', 3 => 'Maintenance' }

  has_many :contract_work_types, dependent: :destroy
  has_many :work_types, through: :contract_work_types
  belongs_to :site
  after_commit :create_helper_associations, on: :create
  after_commit :customer_notification, on: :create

  has_attached_file :document,
                    default_url: '',
                    url: "/contract/:id/document/:basename.:extension",
                    path: '/contract/:id/document/:basename.:extension'
  validates_attachment :document,
                    presence: true,
                    content_type: { content_type: %w(image/jpeg image/jpg image/png image/gif application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }

  has_attached_file :ers_sign_image,
                    default_url: '',
                    url: "/contract/:id/ers_sign/:basename.:extension",
                    path: '/contract/:id/ers_sign/:basename.:extension'
  validates_attachment :ers_sign_image,
                    content_type: { content_type: /^image\/(jpeg|jpg|png|gif|tiff)$/ }

  has_attached_file :customer_sign_image,
                    default_url: '',
                    url: "/contract/:id/customer_sign/:basename.:extension",
                    path: '/contract/:id/customer_sign/:basename.:extension'
  validates_attachment :customer_sign_image,
                    content_type: { content_type: /^image\/(jpeg|jpg|png|gif|tiff)$/ }

  validates :signed_at, :site, :po_number, presence: true
  validates :po_number, uniqueness: true
  validates :price, numericality: true, allow_blank: true
  after_create :transit_site_stage
  before_validation :generate_and_assign_po_number, unless: :po_number?, on: :create
  delegate :project, :production, :billing, to: :site

  def name
    po_number? ? "Contract PO# #{po_number}" : 'Contract'
  end

  def generate_and_assign_po_number
    self.po_number = self.class.generate_po_number
  end

  def has_work_type?(work_type)
    contract_work_types.where(work_type: work_type).present?
  end

  def work_type_names
    work_types.pluck(:name).join(', ')
  end

  def type_string
    TYPE[contract_type]
  end

  private
    def transit_site_stage
      site.to_contract!
    end

    def self.generate_po_number
      (maximum(:po_number) || 49999) + 1
    end

    def create_helper_associations
      ActiveRecord::Base.transaction do
        site.create_billing
        site.create_production
        site.create_project
      end
    end

    def customer_notification
      CustomerMailer.contract_created(self.site, self.site.customer).deliver
    end
end