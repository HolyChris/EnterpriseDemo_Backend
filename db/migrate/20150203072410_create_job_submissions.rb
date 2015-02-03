class CreateJobSubmissions < ActiveRecord::Migration
  def change
    create_table :job_submissions do |t|
      t.string :po_legacy
      t.references :project
      t.integer :shingle_color
      t.integer :drip_color
      t.integer :shingle_manufacturer
      t.integer :shingle_type
      t.decimal :initial_payment, precision: 10, scale: 2
      t.date :initial_payment_date
      t.decimal :completion_payment, precision: 10, scale: 2
      t.date :completion_payment_date
      t.date :submitted_at
      t.integer :work_type
      t.string :claim_number
      t.string :build_type
      t.decimal :deductible, precision: 10, scale: 2
      t.date :deductible_paid_date
      t.decimal :roof_work_rcv, precision: 10, scale: 2
      t.decimal :roof_work_acv, precision: 10, scale: 2
      t.text :roof_type_special_instructions
      t.date :hoa_approval_date
      t.decimal :initial_cost_per_sq, precision: 10, scale: 2
      t.string :mortgage_company
      t.string :loan_number
      t.date :mortgage_inspection_date
      t.boolean :supplement_required
      t.text :supplement_notes
      t.decimal :roof_rcv, precision: 10, scale: 2
      t.decimal :roof_acv, precision: 10, scale: 2
      t.decimal :roof_upgrade_cost, precision: 10, scale: 2
      t.decimal :roof_discount, precision: 10, scale: 2
      t.decimal :roof_total, precision: 10, scale: 2
      t.decimal :gutters_rcv, precision: 10, scale: 2
      t.decimal :gutters_acv, precision: 10, scale: 2
      t.decimal :gutters_upgrade_cost, precision: 10, scale: 2
      t.decimal :gutters_discount, precision: 10, scale: 2
      t.decimal :gutters_total, precision: 10, scale: 2
      t.decimal :siding_rcv, precision: 10, scale: 2
      t.decimal :siding_acv, precision: 10, scale: 2
      t.decimal :siding_upgrade_cost, precision: 10, scale: 2
      t.decimal :siding_discount, precision: 10, scale: 2
      t.decimal :siding_total, precision: 10, scale: 2
      t.decimal :windows_rcv, precision: 10, scale: 2
      t.decimal :windows_acv, precision: 10, scale: 2
      t.decimal :windows_upgrade_cost, precision: 10, scale: 2
      t.decimal :windows_discount, precision: 10, scale: 2
      t.decimal :windows_total, precision: 10, scale: 2
      t.decimal :paint_rcv, precision: 10, scale: 2
      t.decimal :paint_acv, precision: 10, scale: 2
      t.decimal :paint_upgrade_cost, precision: 10, scale: 2
      t.decimal :paint_discount, precision: 10, scale: 2
      t.decimal :paint_total, precision: 10, scale: 2
      t.decimal :hvac_rcv, precision: 10, scale: 2
      t.decimal :hvac_acv, precision: 10, scale: 2
      t.decimal :hvac_upgrade_cost, precision: 10, scale: 2
      t.decimal :hvac_discount, precision: 10, scale: 2
      t.decimal :hvac_total, precision: 10, scale: 2
      t.decimal :deposit_check_amount, precision: 10, scale: 2
      t.decimal :price_per_square
      t.boolean :building_code_upgrade_confirmed
      t.boolean :redeck
      t.boolean :depreciation_recoverable

      t.timestamps
    end
  end
end
