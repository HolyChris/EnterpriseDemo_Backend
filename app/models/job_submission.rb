class JobSubmission < ActiveRecord::Base
  audited

  SHINGLE_COLOR = { 1 => 'Adobe Sunset', 2 => 'Aged Bark', 3 => 'Amalfi Gray', 4 => 'Amalfi Sand', 5 => 'Amber',
                    6 => 'Antique Chestnut', 7 => 'Antique Silver', 8 => 'Antique Slate', 9 => 'Arctic Blue',
                    10 => 'Autumn Blend', 11 => 'Autumn Brown', 12 => 'Autumn Maple', 13 => 'Barkwood',
                    14 => 'Barkwood Slate', 15 => 'Birchwood', 16 => 'Black Oak', 17 => 'Brownwood', 18 => 'Canterbury Black',
                    19 => 'Capri Clay', 20 => 'Carbon', 21 => 'Castillian Surf', 22 => 'Castlewood Gray',
                    23 => 'Cedar', 24 => 'Cederwood Abbey', 25 => 'Charcoal', 26 => 'Charcoal Black', 27 => 'Chateau Gray',
                    28 => 'Chateau Green', 29 => 'Chestnut', 30 => 'Classic Weathered Wood', 31 => 'Desert Tan',
                    32 => 'Driftwood', 33 => 'Dusky Gray', 34 => 'Estate Gray', 35 => 'Fox Hollow Gray', 36 => 'Garnet',
                    37 => 'Granite', 38 => 'Granite Grey', 39 => 'Harbor Blue', 60 => 'Harbor Mist', 40 => 'Heirloom Brown',
                    41 => 'Hickory', 42 => 'Hunter Green', 43 => 'Juniper', 44 => 'Mesa Brown', 45 => 'Mesquite',
                    46 => 'Mission Brown', 47 => 'Mist Grey', 48 => 'Monticello Brown', 49 => 'Onyx Black', 50 => 'Pewter Gray',
                    51 => 'Pinnacle Grey', 52 => 'Pompeii Ash', 53 => 'Quarry Gray', 54 => 'Rustico Clay', 55 => 'Sea Green',
                    56 => 'Sedona Sunset', 57 => 'Shadow Gray', 58 => 'Shadowood', 59 => 'Shakewood', 61 => 'Shasta White',
                    62 => 'Slate', 63 => 'Spanish Tile', 64 => 'Stone Wood', 65 => 'Storm Cloud Gray', 66 => 'Sycamore',
                    67 => 'Teak', 68 => 'Terra Cotta', 69 => 'Timber', 70 => 'Tuscan Sunset', 71 => 'Valencia Sunset',
                    72 => 'Venetian Coral', 73 => 'Venetian Gold', 74 => 'Weathered Timber', 75 => 'Weathered Wood',
                    76 => 'Woodberry Brown', 77 => 'White', 78 => 'Buff', 79 => 'Heather Blend', 80 => 'Black',
                    81 => 'Red Blend', 82 => 'Weatherwood', 83 => 'Oak', 84 => 'Pine Green'}

  DRIP_COLOR = SHINGLE_COLOR
  SHINGLE_MANUFACTURER = {1 => 'GAF', 2 => 'Owens Corning', 3 => 'Certainteed', 4 => 'Decra', 5 => 'Mulehide'}
  SHINGLE_TYPE = {1 => "Timberline HD", 2 => "ArmourShield 2 IR", 3 => "Grand Sequoia IR", 4 => "Grand Sequoia", 5 => "Grand Canyon",
                  6 => "Camelot 2", 7 => "Sienna", 8 => "Woodland", 9 => "Monaco", 10 => "Duration", 11 => "Duration Storm IR",
                  12 => "Woodmoor", 13 => "Woodcrest", 14 => "Presidential Shake", 15 => "Presidential Shake IR", 16 => "Presidential TL",
                  17 => "Tile", 18 => "Villa Tile", 19 => "Shake", 20 => "Shake XD", 21 => 'Modified Bitumen'}
  WORK_TYPE = {}

  belongs_to :project
  validates :roof_work_rcv, :roof_work_acv, :initial_cost_per_sq, :roof_upgrade_cost, :roof_discount, :gutters_rcv,
            :gutters_acv, :gutters_upgrade_cost, :gutters_discount, :gutters_total, :siding_rcv, :siding_acv,
            :siding_upgrade_cost, :siding_discount, :siding_total, :windows_rcv, :windows_acv, :windows_upgrade_cost,
            :windows_discount, :windows_total, :paint_rcv, :paint_acv, :paint_upgrade_cost, :paint_discount, :paint_total,
            :hvac_rcv, :hvac_acv, :hvac_upgrade_cost, :hvac_discount, :hvac_total, numericality: true, allow_blank: true
end
