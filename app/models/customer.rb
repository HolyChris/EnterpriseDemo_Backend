class Customer < ActiveRecord::Base
  audited
  acts_as_paranoid

  has_many :addresses, dependent: :destroy
  has_many :sites, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy
  belongs_to :bill_address, class_name: Address

  validates :firstname, :lastname, :email, :phone_numbers, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: EMAIL_REGEXP }, allow_blank: true

  accepts_nested_attributes_for :bill_address, reject_if: :all_blank #proc { |attributes| attributes.values.all?(&:blank?) }
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :phone_numbers, allow_destroy: true, reject_if: proc { |attributes| attributes[:number].blank? }

  scope :created_by_or_assigned_to, -> (user) { joins("LEFT JOIN audits ON audits.auditable_id = customers.id AND audits.auditable_type = 'Customer'").joins("LEFT JOIN sites ON sites.customer_id = customers.id").joins("LEFT JOIN site_managers ON site_managers.site_id = sites.id").where("(audits.user_type = 'User' AND audits.user_id = #{user.id} AND audits.action = 'create') OR site_managers.user_id = #{user.id}").uniq }

  def fullname
    [firstname, lastname].join(' ')
  end

  def autocomplete_display_value
    "#{fullname} ( #{email} )"
  end

  alias_method :name, :fullname
end