class Appointment < ActiveRecord::Base
  audited
  acts_as_paranoid

  include JqueryDatetimepickable
  jquery_datetimepickable column: :scheduled_at

  OUTCOMES = { 1 => 'Vendor Packet', 2 => 'Meet and Greet', 3 => 'Demo - No Sale', 4 => 'No Demo - No Need', 5 => 'No Demo - Future Need', 6 => 'No Show', 7 => 'No Entry', 8 => 'SOLD', 9 => 'Gaco Bid', 10 => 'Rescheduled', 11 => 'Wrong Address' }

  has_many :follow_ups, dependent: :destroy
  belongs_to :site
  belongs_to :user

  before_save :assign_user_to_site_manager, if: [:user_id?, :user_id_changed?, :site_id?]

  validates :scheduled_at, :site, :user, presence: true

  alias :assigned_to :user

  accepts_nested_attributes_for :follow_ups, allow_destroy: true

  def created_by
    audits.find_by(action: 'create').try(:user)
  end

  def outcome_string
    OUTCOMES[outcome]
  end

  private
    def assign_user_to_site_manager
      unless site.site_managers.where(user_id: user_id).present?
        site_manager = site.site_managers.build(user_id: user_id)
        site_manager.save!
      end
    end
end