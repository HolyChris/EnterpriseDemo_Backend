class ChangePoNumberInContracts < ActiveRecord::Migration

  def up
    remove_column :contracts, :po_number
    add_column :contracts, :po_number, :integer
    add_index :contracts, :po_number
    Contract.all.each{|con| con.generate_and_assign_po_number; con.save;}
  end

  def down
    # Ever you need to reverse this, we did take a dump. Find it in ers production in home folder dump-15-june-vipin.sql
    raise ActiveRecord::IrreversibleMigration, "Can't recover the deleted tags"
  end

end
