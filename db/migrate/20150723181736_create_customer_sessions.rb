class CreateCustomerSessions < ActiveRecord::Migration
  def change
    create_table :customer_sessions do |t|
      t.references :customer
      t.references :site
      t.string :auth_token
      t.datetime :auth_token_created_at

      t.timestamps
    end
    add_index :customer_sessions, :auth_token
  end
end
