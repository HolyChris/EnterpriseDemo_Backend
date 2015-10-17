class AddPrimaryToSiteManagers < ActiveRecord::Migration
  def change
    add_column :site_managers, :primary, :boolean, default: false
  end
end
