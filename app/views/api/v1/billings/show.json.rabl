object :@billing

attributes :id, :initial_payment, :customer_invoice_notes, :invoice_sent_to_customer_method,
           :mortgage_process_notes, :mortgage_check_location, :settled_rcv,
           :settled_scope_paperwork_notes, :final_check_received_amount, :completion_payment,
           :initial_payment_date, :completion_payment_date, :deductible_paid_date, :settled_rcv_date,
           :check_released_date, :final_check_received_date

node(:ready_for_billing_at) {|billing| billing.ready_for_billing_at.try(:iso8601) }
node(:final_invoice_submitted_at) {|billing| billing.final_invoice_submitted_at.try(:iso8601) }
node(:invoice_send_to_manager_at) {|billing| billing.invoice_send_to_manager_at.try(:iso8601) }
node(:invoice_sent_to_customer_at) {|billing| billing.invoice_sent_to_customer_at.try(:iso8601) }


