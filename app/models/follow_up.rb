class FollowUp < ActiveRecord::Base
  audited
  include JqueryDatetimepickable
  jquery_datetimepickable column: :scheduled_at

  belongs_to :appointment

  validates :appointment, :scheduled_at, presence: true
end