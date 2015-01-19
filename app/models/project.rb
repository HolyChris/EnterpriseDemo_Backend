class Project < ActiveRecord::Base
  audited
  acts_as_paranoid
  belongs_to :site

  PRIORITY = { 1 => 'High', 2 => 'Medium', 3 => 'Low' }
  MATERIAL = {  }

  validates :priority, :site, :cost, presence: true
  validates :cost, numericality: true
  validate :verify_contract

  after_create :transit_site_stage

  def po_number
    site.po_number
  end

  def contract
    site.contract
  end

  private
    def transit_site_stage
      site.to_project!
    end

    def verify_contract
      errors.add(:base, 'Contract not present') unless contract.present?
    end
end