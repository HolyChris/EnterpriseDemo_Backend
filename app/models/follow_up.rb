class FollowUp < ActiveRecord::Base
  audited
  just_define_datetime_picker :scheduled_at

  belongs_to :appointment

  validates :appointment, :scheduled_at, presence: true
end