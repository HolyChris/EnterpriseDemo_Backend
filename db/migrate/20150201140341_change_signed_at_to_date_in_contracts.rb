class ChangeSignedAtToDateInContracts < ActiveRecord::Migration
  def up
    change_column :contracts, :signed_at, :date
  end

  def down
    change_column :contracts, :signed_at, :datetime
  end
end
