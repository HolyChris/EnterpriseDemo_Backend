class Project < ActiveRecord::Base
  audited
  acts_as_paranoid

  PRIORITY = { 1 => 'High', 2 => 'Medium', 3 => 'Low' }
  MATERIAL = {  }

  belongs_to :site
  has_one :job_submission, dependent: :destroy
  has_one :roof_accessory_checklist, dependent: :destroy

  validates :priority, :site, :cost, presence: true
  validates :cost, numericality: true
  validate :verify_contract

  after_create :transit_site_stage

  accepts_nested_attributes_for :job_submission, reject_if: lambda {|q| q.values.all?(&:blank?)}
  accepts_nested_attributes_for :roof_accessory_checklist, reject_if: lambda {|q| q.values.all?(&:blank?)}

  def po_number
    site.po_number
  end

  def contract
    site.contract
  end

  def production
    site.production
  end

  private
    def transit_site_stage
      site.to_project!
    end

    def verify_contract
      errors.add(:base, 'Contract not present') unless contract.present?
    end
end