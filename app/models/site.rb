class Site < ActiveRecord::Base
  acts_as_paranoid

  STATUS = { 1 => 'Good', 2 => 'Bad', 3 => 'New', 4 => 'Dead' }
  SOURCE = { 1 => 'Qualified Storm Leads', 2 => 'Commercial Call Leads', 3 => 'Self-Generated', 4 => 'Canvasser', 5 => 'Call in Leads', 6 => 'Mailer', 7 => 'Sign', 8 => 'Website', 9 => 'Friend', 10 => 'Neighbor', 11 => 'Truck Sign', 12 => 'Call/Knock', 13 => 'Other', 14 => 'Existing Customer' }

  include ManageStageFlow

  has_one :contract, dependent: :destroy
  has_many :inspections, dependent: :destroy
  belongs_to :address
  belongs_to :customer
  has_many :site_managers, dependent: :destroy
  has_many :managers, through: :site_managers, source: :user

  validates :name, :stage, :address, :customer, presence: true

  accepts_nested_attributes_for :address
end