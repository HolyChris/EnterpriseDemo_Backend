class FollowUp < ActiveRecord::Base
  belongs_to :appointment
  just_define_datetime_picker :scheduled_at
  validates :appointment, :scheduled_at, presence: true
end