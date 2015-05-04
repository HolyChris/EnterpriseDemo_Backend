class CreateBilling < ActiveRecord::Migration
  def change
    create_table :billings do |t|
      t.references :site
      t.date :ready_for_billing_at
      t.decimal :initial_payment, precision: 10, scale: 2
      t.date :initial_payment_date
      t.date :final_invoice_submitted_at
      t.text :customer_invoice_notes
      t.date :invoice_send_to_manager_at
      t.string :invoice_sent_to_customer_method
      t.decimal :completion_payment, precision: 10, scale: 2
      t.date :completion_payment_date
      t.text :mortgage_process_notes
      t.string :mortgage_check_location
      t.date :deductible_paid_date
      t.decimal :settled_rcv, precision: 10, scale: 2
      t.date :settled_rcv_date
      t.text :settled_scope_paperwork_notes
      t.decimal :final_check_received_amount, precision: 10, scale: 2
      t.date :check_released_date
      t.date :final_check_received_date
      t.date :invoice_sent_to_customer_at
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
