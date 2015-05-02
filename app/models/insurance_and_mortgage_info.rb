class InsuranceAndMortgageInfo < ActiveRecord::Base
  audited

  belongs_to :project
  validates :deductible, numericality: true, allow_blank: true
end