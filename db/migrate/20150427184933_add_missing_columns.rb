class AddMissingColumns < ActiveRecord::Migration
  def change
    add_column :sites, :source_info, :string
    add_column :contracts, :contract_type, :integer
    add_index :contracts, :contract_type
  end
end
