class CreateSiteManagers < ActiveRecord::Migration
  def change
    create_table :site_managers do |t|
      t.references :site
      t.references :user

      t.timestamps
    end
  end
end
