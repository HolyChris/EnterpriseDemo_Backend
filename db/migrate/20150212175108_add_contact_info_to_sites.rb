class AddContactInfoToSites < ActiveRecord::Migration
  def change
    add_column :sites, :contact_name, :string
    add_column :sites, :contact_phone, :string
  end
end
