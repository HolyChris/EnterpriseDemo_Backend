class AddReadyForProductionAtToProductions < ActiveRecord::Migration
  def up
    add_column :productions, :ready_for_production_at, :date

    Production.reset_column_information

    Production.all.each do |production|
      production.update_column(:ready_for_production_at, production.created_at)
    end
  end

  def down
    remove_column :productions, :ready_for_production_at
  end
end
