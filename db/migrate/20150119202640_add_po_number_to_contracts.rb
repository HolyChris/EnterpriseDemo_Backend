class AddPoNumberToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :po_number, :string
    add_column :contracts, :deleted_at, :datetime

    add_index :contracts, :po_number
  end
end
