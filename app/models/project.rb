class Project < ActiveRecord::Base
  audited
  acts_as_paranoid

  PRIORITY = { 1 => 'High', 2 => 'Medium', 3 => 'Low' }

  belongs_to :site
  has_one :job_submission, dependent: :destroy
  has_one :insurance_and_mortgage_info, dependent: :destroy

  validates :priority, :site, presence: true
  validate :verify_contract

  after_create :transit_site_stage

  accepts_nested_attributes_for :job_submission, reject_if: lambda {|q| q.values.all?(&:blank?)}
  accepts_nested_attributes_for :insurance_and_mortgage_info, reject_if: lambda {|q| q.values.all?(&:blank?)}

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