class AddCoverPhotoAolumnsToSite < ActiveRecord::Migration
  def up
    add_attachment :sites, :cover_photo
  end

  def down
    remove_attachment :sites, :cover_photo
  end
end
