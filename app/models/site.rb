class Site < ActiveRecord::Base
  audited
  acts_as_paranoid

  STATUS = { 1 => 'Good', 2 => 'Bad', 3 => 'New', 4 => 'Dead' }
  SOURCE = { 1 => 'Qualified Storm Leads', 2 => 'Commercial Call Leads', 3 => 'Self-Generated', 4 => 'Canvasser', 5 => 'Call in Leads', 6 => 'Mailer', 7 => 'Sign', 8 => 'Website', 9 => 'Friend', 10 => 'Neighbor', 11 => 'Truck Sign', 12 => 'Call/Knock', 13 => 'Other', 14 => 'Existing Customer' }
  STAGE = { lead: 1, contract: 2, project: 3, production: 4, billing: 5 }
  STAGE_MAPPING = { lead: 'Opportunity', contract: 'Under Contract', project: 'Under Contract', production: 'Production', billing: 'Billing' }

  include ManageStageFlow

  attr_accessor :bill_addr_same_as_addr
  attr_accessor :current_stage

  has_one :contract, dependent: :destroy
  has_one :project, dependent: :destroy
  has_one :production, dependent: :destroy
  has_one :billing, dependent: :destroy

  has_many :assets, as: :viewable, dependent: :destroy, class_name: "Asset"
  has_many :images, -> { images }, as: :viewable, class_name: "Asset"
  has_many :documents, -> { docs }, as: :viewable, class_name: "Asset"
  has_many :inspections, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :site_managers, dependent: :destroy
  has_many :managers, through: :site_managers, source: :user

  belongs_to :bill_address, class_name: Address
  belongs_to :address
  belongs_to :customer

  validates :stage, :address, :customer, presence: true

  accepts_nested_attributes_for :bill_address, reject_if: :all_blank #proc { |attributes| attributes.values.all?(&:blank?) }
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :images

  before_validation :assign_customer, if: 'address.present?'

  scope :created_by_or_assigned_to, -> (user) { joins("LEFT JOIN audits ON audits.auditable_id = sites.id AND audits.auditable_type = 'Site'").joins("LEFT JOIN site_managers ON site_managers.site_id = sites.id").where("(audits.user_type = 'User' AND audits.user_id = #{user.id} AND audits.action = 'create') OR site_managers.user_id = #{user.id}").uniq }


  def self.find_by_po_number(_po_number)
    joins(:contract).where('contracts.po_number = ?', _po_number).first
  end


  def bill_addr_same_as_addr
    address_id? && address_id == bill_address_id
  end

  def bill_addr_same_as_addr=(value)
    if value == true || value == '1' || value == 1
      self.bill_address_id = self.address_id
    end
  end

  def po_number
    contract.try(:po_number)
  end

  def status_string
    STATUS[status]
  end

  def source_string
    SOURCE[source]
  end

  def stage_string
    STAGE_MAPPING[stage.to_s.to_sym]
  end

  private
    def assign_customer
      self.customer_id ||= address.customer.try(:id)
    end
end
