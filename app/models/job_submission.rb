class JobSubmission < ActiveRecord::Base
  audited
  SHINGLE_COLOR = {  }
  DRIP_COLOR = {  }
  SHINGLE_MANUFACTURER = {  }
  SHINGLE_TYPE = {  }
  WORK_TYPE = {  }

  belongs_to :project
  validates :initial_payment, :completion_payment, :deductible, :roof_work_rcv, :roof_work_acv,
            :initial_cost_per_sq, :roof_rcv, :roof_acv, :roof_upgrade_cost, :roof_discount, :roof_total, :gutters_rcv,
            :gutters_acv, :gutters_upgrade_cost, :gutters_discount, :gutters_total, :siding_rcv, :siding_acv, :siding_upgrade_cost, :siding_discount,
            :siding_total, :windows_rcv, :windows_acv, :windows_upgrade_cost, :windows_discount, :windows_total, :paint_rcv,
            :paint_acv, :paint_upgrade_cost, :paint_discount, :paint_total, :hvac_rcv, :hvac_acv, :hvac_upgrade_cost, :hvac_discount, :hvac_total,
            :deposit_check_amount, :price_per_square, numericality: true, allow_blank: true
end