class Production < ActiveRecord::Base
  audited
  acts_as_paranoid

  has_one :order_material, dependent: :destroy
  belongs_to :site

  validates :site, :delivery_date, :production_date, :roof_built_date, presence: true

  after_create :transit_site_stage
  accepts_nested_attributes_for :order_material, reject_if: :all_blank

  def contract
    site.contract
  end

  def project
    site.project
  end

  private
    def transit_site_stage
      site.to_production!
    end
end