class CreateContractWorkTypes < ActiveRecord::Migration
  def change
    create_table :contract_work_types do |t|
      t.integer :contract_id
      t.integer :work_type_id
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :contract_work_types, :contract_id
    add_index :contract_work_types, :work_type_id
  end
end
