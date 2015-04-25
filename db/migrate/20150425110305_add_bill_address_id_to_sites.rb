class AddBillAddressIdToSites < ActiveRecord::Migration
  def up
    add_column :sites, :bill_address_id, :integer
    add_index :sites, :bill_address_id

    Customer.where.not(bill_address_id: nil).includes(:sites).each do |customer|
      if bill_address = Address.find_by(id: customer.bill_address_id)
        customer.sites.each_with_index do |site, index|
          if index == 0
            site.bill_address_id = bill_address.id
          else
            address = Address.create!(bill_address.attributes.except('id', 'updated_at', 'created_at', 'deleted_at'))
            site.bill_address_id = address.id
          end
          site.save!
        end
      end
    end

    remove_column :customers, :bill_address_id
  end

  def down
    add_column :customers, :bill_address_id, :integer
    add_index :customers, :bill_address_id

    Customer.includes(:sites).each do |customer|
      if bill_address_id = customer.sites.last.try(:bill_address_id)
        customer.update_column(:bill_address_id, bill_address_id)
      end
    end

    remove_column :sites, :bill_address_id
  end
end
