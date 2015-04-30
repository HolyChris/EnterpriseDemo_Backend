object :@project

attributes :id, :po_number, :insurance_carrier, :re_roof_material, :color

node(:priority) { |project| Project::PRIORITY[project.priority] }
node(:material) {|project| Project::MATERIAL[project.material] }

child(:job_submission) do
  attributes :id, :po_legacy, :initial_payment_date, :completion_payment_date, :submitted_at, :claim_number, :build_type, :deductible_paid_date, :roof_type_special_instructions, :hoa_approval_date, :mortgage_company, :loan_number, :mortgage_inspection_date, :supplement_required, :supplement_notes, :building_code_upgrade_confirmed, :redeck

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
  node(:roof_upgrade_cost) { |job_submission| number_to_currency(job_submission.roof_upgrade_cost) }
  node(:roof_discount) { |job_submission| number_to_currency(job_submission.roof_discount) }
  node(:roof_total) { |job_submission| number_to_currency(job_submission.roof_total) }
  node(:gutters_rcv) { |job_submission| number_to_currency(job_submission.gutters_rcv) }
  node(:gutters_upgrade_cost) { |job_submission| number_to_currency(job_submission.gutters_upgrade_cost) }
  node(:gutters_discount) { |job_submission| number_to_currency(job_submission.gutters_discount) }
  node(:gutters_total) { |job_submission| number_to_currency(job_submission.gutters_total) }
  node(:siding_rcv) { |job_submission| number_to_currency(job_submission.siding_rcv) }
  node(:siding_upgrade_cost) { |job_submission| number_to_currency(job_submission.siding_upgrade_cost) }
  node(:siding_discount) { |job_submission| number_to_currency(job_submission.siding_discount) }
  node(:siding_total) { |job_submission| number_to_currency(job_submission.siding_total) }
  node(:windows_rcv) { |job_submission| number_to_currency(job_submission.windows_rcv) }
  node(:windows_upgrade_cost) { |job_submission| number_to_currency(job_submission.windows_upgrade_cost) }
  node(:windows_discount) { |job_submission| number_to_currency(job_submission.windows_discount) }
  node(:windows_total) { |job_submission| number_to_currency(job_submission.windows_total) }
  node(:paint_rcv) { |job_submission| number_to_currency(job_submission.paint_rcv) }
  node(:paint_upgrade_cost) { |job_submission| number_to_currency(job_submission.paint_upgrade_cost) }
  node(:paint_discount) { |job_submission| number_to_currency(job_submission.paint_discount) }
  node(:paint_total) { |job_submission| number_to_currency(job_submission.paint_total) }
  node(:hvac_rcv) { |job_submission| number_to_currency(job_submission.hvac_rcv) }
  node(:hvac_upgrade_cost) { |job_submission| number_to_currency(job_submission.hvac_upgrade_cost) }
  node(:hvac_discount) { |job_submission| number_to_currency(job_submission.hvac_discount) }
  node(:hvac_total) { |job_submission| number_to_currency(job_submission.hvac_total) }
  node(:deposit_check_amount) { |job_submission| number_to_currency(job_submission.deposit_check_amount) }
end

child(:site) do
  attributes :id, :name, :source_info, :damage, :contact_name, :contact_phone

  node(:bill_addr_same_as_addr) { |site| site.bill_addr_same_as_addr }
  node(:stage) {|site| site.stage_string}
  node(:po_number) {|site| site.po_number}
  node(:source) {|site| site.source_string}
  node(:status) {|site| site.status_string}
end