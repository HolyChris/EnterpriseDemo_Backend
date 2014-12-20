class SiteManager < ActiveRecord::Base
  belongs_to :site
  belongs_to :user

  validates :site, :user, presence: true
end