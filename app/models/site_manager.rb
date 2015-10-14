class SiteManager < ActiveRecord::Base
  belongs_to :site
  belongs_to :user

  validates :site, :user, presence: true

  before_save :manage_primary, if: [:primary?, :primary_changed?]

  private
    def manage_primary
      site.site_managers.where.not(id: id).update_all(primary: false)
    end
end
