  class ChangePricePrecisionOfContract < ActiveRecord::Migration
  def up
    change_column :contracts, :price, :decimal, precision: 20, scale: 2
  end

  def down
    change_column :contracts, :price, :decimal, precision: 10, scale: 2
  end
end
