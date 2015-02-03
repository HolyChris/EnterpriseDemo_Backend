class Skylight < ActiveRecord::Base
  audited

  belongs_to :roof_accessory_checklist
end