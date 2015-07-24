object :@project

attributes :id, :po_number, :po_legacy, :existing_roof_material, :code_coverage_confirmed, :hoa_approval_date, :last_roof_built_date

node(:priority) { |project| Project::PRIORITY[project.priority] }

child(:insurance_and_mortgage_info) do
  attributes :id, :insurance_carrier, :claim_number, :loan_tracking_number, :mortgage_company

  node(:deductible) { |insurance_and_mortgage_info| number_to_currency(insurance_and_mortgage_info.deductible) }
end

child(:job_submission) do
  attributes :id, :roof_type_special_instructions, :redeck

  node(:shingle_color) { |job_submission| job_submission.shingle_color }
  node(:drip_color) { |job_submission| job_submission.drip_color }
  node(:shingle_manufacturer) { |job_submission| job_submission.shingle_manufacturer }
  node(:shingle_type) { |job_submission| job_submission.shingle_type }
  node(:work_type) { |job_submission| job_submission.work_type }
  node(:roof_work_rcv) { |job_submission| number_to_currency(job_submission.roof_work_rcv) }
  node(:roof_work_acv) { |job_submission| number_to_currency(job_submission.roof_work_acv) }
  node(:initial_cost_per_sq) { |job_submission| number_to_currency(job_submission.initial_cost_per_sq) }
  node(:roof_upgrade_cost) { |job_submission| number_to_currency(job_submission.roof_upgrade_cost) }
  node(:roof_discount) { |job_submission| number_to_currency(job_submission.roof_discount) }
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
end

child(:site) do
  attributes :id, :name, :source_info, :damage, :contact_name, :contact_phone

  node(:bill_addr_same_as_addr) { |site| site.bill_addr_same_as_addr }
  node(:stage) {|site| site.stage_string}
  node(:po_number) {|site| site.po_number}
  node(:source) {|site| site.source_string}
  node(:status) {|site| site.status_string}
end
