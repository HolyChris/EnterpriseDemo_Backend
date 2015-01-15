class AddDeletedAtToUsersSitesAddressesCustomers < ActiveRecord::Migration
  def change
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at

    add_column :sites, :deleted_at, :datetime
    add_index :sites, :deleted_at

    add_column :addresses, :deleted_at, :datetime
    add_index :addresses, :deleted_at

    add_column :customers, :deleted_at, :datetime
    add_index :customers, :deleted_at
  end
end
