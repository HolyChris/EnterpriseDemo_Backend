class Billing < ActiveRecord::Base
  audited
  acts_as_paranoid

  belongs_to :site

  validates :site, :ready_for_billing_at, presence: true
  validates :initial_payment, :completion_payment, :settled_rcv, :final_check_received_amount, numericality: true, allow_blank: true

  # Chris asked to get rid of it
  # after_create :transit_site_stage

  delegate :project, :production, :contract, to: :site
  
  def initialize(*args)
    super
    self.ready_for_billing_at = Date.current
  end

  private
    def transit_site_stage
      site.to_billing!
    end
end