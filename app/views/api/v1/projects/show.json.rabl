object :@project

attributes :id, :po_number, :insurance_carrier, :re_roof_material, :color

node(:priority) { |project| Project::PRIORITY[project.priority] }
node(:cost) { |project| number_to_currency(project.cost) }
node(:material) {|project| Project::MATERIAL[project.material] }

child(:roof_accessory_checklist) do
  attributes :id, :open_soffits, :soffit_depth, :pipe_jacks_1_3, :pipe_jacks_4_5,
              :pitched_metal_jacks_collar_and_cap_diameter, :meter_mast_boot, :counter_flashing, :head_wall_4_5,
              :step_flashing, :large_step_flashing, :drip_2_4_color, :drip_2_4, :broan_bath_vent_4, :broan_vent_6,
              :slant_backs_turtle_t_vent, :solar_power_vent, :hard_wired_power_vent, :ridge_vent, :standard_ridge,
              :mid_ridge, :high_ridge, :chimney_1_size, :chimney_2_size, :build_cricket, :house_redeck_sq,
              :garage_redeck, :flat_redeck, :layers_house_comp, :layers_garage_comp, :layers_flat_comp,
              :layers_house_shake, :layers_garage_shake, :layers_flat_shake, :squares_house, :squares_garage,
              :squares_low_slope_2_12_4_12, :squares_flat_lt_2_12, :pitch_predominate, :pitch_steep_gt_8_12,
              :pitch_4_12_8_12, :pitch_2_12_4_12, :pitch_flat_lt_2_12, :d_r_gutters, :remove_gutters, :d_r_downspouts,
              :remove_downspouts

  node(:access) { |roof_accessory_checklist| RoofAccessoryChecklist::ACCESS[roof_accessory_checklist.access] }

  child(:skylights) do
    attributes :id, :existing, :curb_size, :od_frame_size, :new_skylight,
              :curb_mount, :deck_mount, :special_instructions
  end
end

child(:job_submission) do
  attributes :id, :po_legacy, :initial_payment_date, :completion_payment_date, :submitted_at, :claim_number, :build_type, :deductible_paid_date, :roof_type_special_instructions, :hoa_approval_date, :mortgage_company, :loan_number, :mortgage_inspection_date, :supplement_required, :supplement_notes, :building_code_upgrade_confirmed, :redeck, :depreciation_recoverable

  node(:shingle_color) { |job_submission| JobSubmission::SHINGLE_COLOR[job_submission.shingle_color] }
  node(:drip_color) { |job_submission| JobSubmission::DRIP_COLOR[job_submission.drip_color] }
  node(:shingle_manufacturer) { |job_submission| JobSubmission::SHINGLE_MANUFACTURER[job_submission.shingle_manufacturer] }
  node(:shingle_type) { |job_submission| JobSubmission::SHINGLE_TYPE[job_submission.shingle_type] }
  node(:initial_payment) { |job_submission| number_to_currency(job_submission.initial_payment) }
  node(:completion_payment) { |job_submission| number_to_currency(job_submission.completion_payment) }
  node(:work_type) { |job_submission| JobSubmission::WORK_TYPE[job_submission.work_type] }
  node(:deductible) { |job_submission| number_to_currency(job_submission.deductible) }
  node(:roof_work_rcv) { |job_submission| number_to_currency(job_submission.roof_work_rcv) }
  node(:roof_work_acv) { |job_submission| number_to_currency(job_submission.roof_work_acv) }
  node(:initial_cost_per_sq) { |job_submission| number_to_currency(job_submission.initial_cost_per_sq) }
  node(:initial_cost_per_sq) { |job_submission| number_to_currency(job_submission.initial_cost_per_sq) }
  node(:roof_rcv) { |job_submission| number_to_currency(job_submission.roof_rcv) }
  node(:roof_acv) { |job_submission| number_to_currency(job_submission.roof_acv) }
  node(:roof_upgrade_cost) { |job_submission| number_to_currency(job_submission.roof_upgrade_cost) }
  node(:roof_discount) { |job_submission| number_to_currency(job_submission.roof_discount) }
  node(:roof_total) { |job_submission| number_to_currency(job_submission.roof_total) }
  node(:gutters_rcv) { |job_submission| number_to_currency(job_submission.gutters_rcv) }
  node(:gutters_acv) { |job_submission| number_to_currency(job_submission.gutters_acv) }
  node(:gutters_upgrade_cost) { |job_submission| number_to_currency(job_submission.gutters_upgrade_cost) }
  node(:gutters_discount) { |job_submission| number_to_currency(job_submission.gutters_discount) }
  node(:gutters_total) { |job_submission| number_to_currency(job_submission.gutters_total) }
  node(:siding_rcv) { |job_submission| number_to_currency(job_submission.siding_rcv) }
  node(:siding_acv) { |job_submission| number_to_currency(job_submission.siding_acv) }
  node(:siding_upgrade_cost) { |job_submission| number_to_currency(job_submission.siding_upgrade_cost) }
  node(:siding_discount) { |job_submission| number_to_currency(job_submission.siding_discount) }
  node(:siding_total) { |job_submission| number_to_currency(job_submission.siding_total) }
  node(:windows_rcv) { |job_submission| number_to_currency(job_submission.windows_rcv) }
  node(:windows_acv) { |job_submission| number_to_currency(job_submission.windows_acv) }
  node(:windows_upgrade_cost) { |job_submission| number_to_currency(job_submission.windows_upgrade_cost) }
  node(:windows_discount) { |job_submission| number_to_currency(job_submission.windows_discount) }
  node(:windows_total) { |job_submission| number_to_currency(job_submission.windows_total) }
  node(:paint_rcv) { |job_submission| number_to_currency(job_submission.paint_rcv) }
  node(:paint_acv) { |job_submission| number_to_currency(job_submission.paint_acv) }
  node(:paint_upgrade_cost) { |job_submission| number_to_currency(job_submission.paint_upgrade_cost) }
  node(:paint_discount) { |job_submission| number_to_currency(job_submission.paint_discount) }
  node(:paint_total) { |job_submission| number_to_currency(job_submission.paint_total) }
  node(:hvac_rcv) { |job_submission| number_to_currency(job_submission.hvac_rcv) }
  node(:hvac_acv) { |job_submission| number_to_currency(job_submission.hvac_acv) }
  node(:hvac_upgrade_cost) { |job_submission| number_to_currency(job_submission.hvac_upgrade_cost) }
  node(:hvac_discount) { |job_submission| number_to_currency(job_submission.hvac_discount) }
  node(:hvac_total) { |job_submission| number_to_currency(job_submission.hvac_total) }
  node(:deposit_check_amount) { |job_submission| number_to_currency(job_submission.deposit_check_amount) }
  node(:price_per_square) { |job_submission| number_to_currency(job_submission.price_per_square) }
end

child(:site) do
  attributes :id, :name, :damage, :roof_built_at, :insurance_company, :claim_number, :mortgage_company, :loan_tracking_number

  node(:source) {|site| Site::SOURCE[site.source]}
  node(:status) {|site| Site::STATUS[site.status]}
end