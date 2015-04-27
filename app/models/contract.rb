class Contract < ActiveRecord::Base
  audited
  acts_as_paranoid

  just_define_datetime_picker :signed_at

  TYPE = { 1 => 'Cash', 2 => 'Insurance', 3 => 'Maintenance' }

  belongs_to :site

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

  validates :signed_at, :price, :site, :po_number, presence: true
  validates :po_number, uniqueness: true
  validates :price, :paid_till_now, numericality: true
  after_create :transit_site_stage
  before_validation :generate_and_assign_po_number, unless: :po_number?

  def name
    po_number? ? "Contract PO# #{po_number}" : 'Contract'
  end

  def generate_and_assign_po_number
    self.po_number = generate_po_number
  end

  def project
    site.project
  end

  def type_string
    TYPE[contract_type]
  end

  private
    def transit_site_stage
      site.to_contract!
    end

    def generate_po_number
      loop do
        random_token = SecureRandom.hex[0,10].upcase
        break random_token unless Contract.exists?(po_number: random_token)
      end
    end
end