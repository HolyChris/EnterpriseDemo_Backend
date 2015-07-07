class JobSubmission < ActiveRecord::Base
  audited
  SHINGLE_COLOR = {1 => 'Almond', 2 => 'Amber', 3 => 'Antique Ivory', 4 => 'Antique Silver', 5 => 'Antique Slate', 6 => 'Autumn brown', 7 => 'Barkwood', 8 => 'Black', 9 => 'Black Oak', 10 => 'Bone White', 11 => 'Brown', 12 => 'Brownwood', 13 => 'Buff', 14 => 'Cedar', 15 => 'Charcoal', 16 => 'Chateau Green', 17 => 'Chestnut', 18 => 'Classic Green', 19 => 'Colonial Red', 20 => 'Copper Penny', 21 => 'Dark Bronze', 22 => 'Desert Tan', 23 => 'Driftwood', 24 => 'Dusky Gray', 25 => 'Estate Gray', 26 => 'Fox Hollow Gray', 27 => 'Galvanized', 28 => 'Gray Slate', 29 => 'Green', 30 => 'Harbor Blue', 31 => 'Hartford Green', 32 => 'Harvest Brown', 33 => 'Heatherblend', 34 => 'Hickory', 35 => 'Hunt Green', 36 => 'Mansard Brown', 37 => 'Med BZ', 38 => 'Medium Bronze', 39 => 'Mesa Brown', 40 => 'Midnight Blush', 41 => 'Mission Brown', 42 => 'Moss Green', 43 => 'Mystic Slate', 44 => 'Oak', 45 => 'Onyx Black', 46 => 'Patriot Red', 47 => 'Pewter Gray', 48 => 'Pine Green', 49 => 'Quarry Gray', 50 => 'Red', 51 => 'Red Blend', 52 => 'Sedona Sunset', 53 => 'Shake wood', 54 => 'Shakewood', 55 => 'Shasta White', 56 => 'Sierra Gray', 57 => 'Sierra Tan', 58 => 'Slate', 59 => 'Slate Blue', 60 => 'Slate Gray', 61 => 'Stone Wood', 62 => 'Storm Cloud Gray', 63 => 'Tan', 64 => 'Teak', 65 => 'Terra BZ', 66 => 'Terracotta', 67 => 'Weather Wood', 68 => 'Weathered Wood', 69 => 'White'}
  DRIP_COLOR = SHINGLE_COLOR
  SHINGLE_MANUFACTURER = {  }
  SHINGLE_TYPE = {  }
  WORK_TYPE = {  }

  belongs_to :project
  validates :roof_work_rcv, :roof_work_acv, :initial_cost_per_sq, :roof_upgrade_cost, :roof_discount, :gutters_rcv,
            :gutters_acv, :gutters_upgrade_cost, :gutters_discount, :gutters_total, :siding_rcv, :siding_acv,
            :siding_upgrade_cost, :siding_discount, :siding_total, :windows_rcv, :windows_acv, :windows_upgrade_cost,
            :windows_discount, :windows_total, :paint_rcv, :paint_acv, :paint_upgrade_cost, :paint_discount, :paint_total,
            :hvac_rcv, :hvac_acv, :hvac_upgrade_cost, :hvac_discount, :hvac_total, numericality: true, allow_blank: true
end