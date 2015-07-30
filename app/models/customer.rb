class Customer < ActiveRecord::Base
  audited
  acts_as_paranoid

  has_many :addresses, dependent: :destroy
  has_many :sites, dependent: :destroy
  has_one :primary_phone_number, -> { primary }, inverse_of: :customer, class_name: PhoneNumber
  has_many :phone_numbers, inverse_of: :customer, dependent: :destroy
  has_many :customer_sessions, dependent: :destroy

  has_secure_token :page_token

  validates :firstname, :lastname, presence: true
  validates :email, format: { with: EMAIL_REGEXP }, allow_blank: true

  validate :ensure_single_primary_phone_number

  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :phone_numbers, allow_destroy: true, reject_if: proc { |attributes| attributes[:number].blank? }

  scope :created_by_or_assigned_to, -> (user) { joins("LEFT JOIN audits ON audits.auditable_id = customers.id AND audits.auditable_type = 'Customer'").joins("LEFT JOIN sites ON sites.customer_id = customers.id").joins("LEFT JOIN site_managers ON site_managers.site_id = sites.id").where("(audits.user_type = 'User' AND audits.user_id = #{user.id} AND audits.action = 'create') OR site_managers.user_id = #{user.id}").uniq }

  def fullname
    [firstname, lastname].join(' ')
  end

  def autocomplete_display_value
    [fullname, primary_phone_number.try(:number_string)].join(', ')
  end

  alias_method :name, :fullname

  private

    def ensure_single_primary_phone_number
      errors.add(:base, 'Customer should have a primary phone number.') if phone_numbers.select(&:primary?).length != 1
    end
end
