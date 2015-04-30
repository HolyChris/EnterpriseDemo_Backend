class WorkType < ActiveRecord::Base
  has_many :contract_work_types, dependent: :destroy
  has_many :contracts, through: :contract_work_types

  validates :name, presence: true, uniqueness: true
end