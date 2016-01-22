class AddInsuranceAdjustorIdToSites < ActiveRecord::Migration
  def change
      add_column :sites, :insurance_adjustor_id, :integer
      remove_column :insurance_adjustors, :site_id
  end
end
