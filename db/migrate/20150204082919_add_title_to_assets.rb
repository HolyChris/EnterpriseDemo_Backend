class AddTitleToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :doc_type, :integer
    add_column :assets, :title, :string
  end
end
