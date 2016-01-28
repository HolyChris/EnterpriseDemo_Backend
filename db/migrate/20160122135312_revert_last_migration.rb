class RevertLastMigration < ActiveRecord::Migration
  def change
    add_column :insurance_adjustors, :site_id, :integer
    remove_column :sites, :insurance_adjustor_id
  end
end
