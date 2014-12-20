class Inspection < ActiveRecord::Base
  belongs_to :site

  validates :completed_at, :site_id, presence: true
end