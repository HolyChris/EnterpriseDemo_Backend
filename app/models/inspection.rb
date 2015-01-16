class Inspection < ActiveRecord::Base
  audited
  belongs_to :site

  validates :completed_at, :site_id, presence: true
end