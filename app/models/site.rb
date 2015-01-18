class Site < ActiveRecord::Base
  audited
  acts_as_paranoid

  STATUS = { 1 => 'Good', 2 => 'Bad', 3 => 'New', 4 => 'Dead' }
  SOURCE = { 1 => 'Qualified Storm Leads', 2 => 'Commercial Call Leads', 3 => 'Self-Generated', 4 => 'Canvasser', 5 => 'Call in Leads', 6 => 'Mailer', 7 => 'Sign', 8 => 'Website', 9 => 'Friend', 10 => 'Neighbor', 11 => 'Truck Sign', 12 => 'Call/Knock', 13 => 'Other', 14 => 'Existing Customer' }
  STAGE = { 1 => 'Lead', 2 => 'Contract', 3 => 'Project' }

  include ManageStageFlow

  has_one :contract, dependent: :destroy

  has_many :assets, as: :viewable, dependent: :destroy, class_name: "Asset"
  has_many :images, -> { images }, as: :viewable, class_name: "Asset"
  has_many :docs, -> { docs }, as: :viewable, class_name: "Asset"
  has_many :inspections, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :site_managers, dependent: :destroy
  has_many :managers, through: :site_managers, source: :user

  belongs_to :address
  belongs_to :customer

  validates :name, :stage, :address, :customer, presence: true

  accepts_nested_attributes_for :address

  before_validation :assign_customer, if: 'address.present?'

  private
    def assign_customer
      self.customer_id = address.customer.try(:id)
    end
end