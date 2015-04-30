class ContractWorkType < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :contract
  belongs_to :work_type

  validates :contract, :work_type, presence: true
  validates :contract_id, uniqueness: { scope: :work_type_id }

end