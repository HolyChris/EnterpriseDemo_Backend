class Production < ActiveRecord::Base
  audited
  acts_as_paranoid

  belongs_to :site

  validates :site, presence: true
  validates :paid_till_now, numericality: true, allow_blank: true

  before_update :notify_customer

  delegate :project, :contract, :billing, to: :site

  def initialize(*args)
    super
    self.ready_for_production_at = Date.current
  end

  private
    def transit_site_stage
      site.to_production!
    end

    def notify_customer
      if self.delivery_date_changed?
        client = Twilio::REST::Client.new
        customer = self.site.customer
        client.messages.create(
            from: '+15005550006',
            to: customer.primary_phone_number.number,
            body: "Material delivery date set to #{self.delivery_date}."
        )
        end
    end

end