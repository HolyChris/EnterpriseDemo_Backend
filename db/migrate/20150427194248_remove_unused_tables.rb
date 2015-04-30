class RemoveUnusedTables < ActiveRecord::Migration
  def change
    drop_table :roof_accessory_checklists
    drop_table :skylights
    drop_table :order_materials
  end
end
