class AddPageTokenToCustomers < ActiveRecord::Migration
  def up
    add_column :customers, :page_token, :string
    add_index :customers, :page_token
    Customer.find_each{|cust| cust.regenerate_page_token }
  end

  def down
    remove_column :customers, :page_token
  end
end
