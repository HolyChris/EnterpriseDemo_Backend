class MoveFieldsAmongTables < ActiveRecord::Migration
  def up
    add_column :productions, :paid_till_now, :decimal, precision: 10, scale: 2

    Production.reset_column_information

    Contract.joins(site: :production).where.not(contracts: { paid_till_now: nil }).each do |contract|
      if production = contract.site.production
        production.update_column(:paid_till_now, contract.paid_till_now)
      end
    end

    remove_column :contracts, :paid_till_now
  end

  def down
    add_column :contracts, :paid_till_now, :decimal, precision: 10, scale: 2
    Contract.reset_column_information

    Production.where.not(productions: { paid_till_now: nil }).each do |production|
      if contract = production.site.contract
        contract.update_column(:paid_till_now, production.paid_till_now)
      end
    end

    remove_column :productions, :paid_till_now
  end
end
