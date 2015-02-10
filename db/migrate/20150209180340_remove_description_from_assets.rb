class RemoveDescriptionFromAssets < ActiveRecord::Migration
  def up
    remove_column :assets, :description
  end

  def down
    add_column :assets, :description, :text
  end
end
