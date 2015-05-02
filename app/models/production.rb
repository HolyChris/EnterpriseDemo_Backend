class Production < ActiveRecord::Base
  audited
  acts_as_paranoid

  belongs_to :site

  validates :site, :delivery_date, :production_date, presence: true
  validates :paid_till_now, numericality: true, allow_blank: true

  after_create :transit_site_stage

  delegate :project, :contract, :billing, to: :site

  private
    def transit_site_stage
      site.to_production!
    end
end