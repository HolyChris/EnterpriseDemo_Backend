class Site < ActiveRecord::Base
  STATUS = { 1 => 'Good', 2 => 'Bad', 4 => 'Dead' }
  SOURCE = {}

  include ManageStageFlow

  has_one :contract
  has_many :inspections
  belongs_to :address
  belongs_to :customer
  has_many :site_managers
  has_many :managers, through: :site_managers, source: :user

  validates :name, :stage, :address, :customer, presence: true

  accepts_nested_attributes_for :address
end