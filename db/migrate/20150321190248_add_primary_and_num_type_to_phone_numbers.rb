class AddPrimaryAndNumTypeToPhoneNumbers < ActiveRecord::Migration
  def change
    add_column :phone_numbers, :primary, :boolean, default: false
    add_column :phone_numbers, :num_type, :integer

    add_index :phone_numbers, :primary
    add_index :phone_numbers, :num_type
  end
end
