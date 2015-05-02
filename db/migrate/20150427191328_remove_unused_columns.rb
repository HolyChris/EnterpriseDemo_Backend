class RemoveUnusedColumns < ActiveRecord::Migration
  def up
    Site.joins(:production).where.not(roof_built_at: nil).each do |site|
      if site.production.roof_built_date.blank?
        site.production.update_column(:roof_built_date, site.roof_built_at)
      end
    end

    Site.joins(:project).each do |site|
      project = site.project
      project.insurance_carrier = site.insurance_company if project.insurance_carrier.blank?
      if job_submission = project.job_submission
        job_submission.mortgage_company = site.mortgage_company if job_submission.mortgage_company.blank?
        job_submission.loan_number = site.loan_tracking_number if job_submission.loan_number.blank?
        job_submission.claim_number = site.claim_number if job_submission.claim_number.blank?
        job_submission.save if job_submission.changed?
      end
      project.save if project.changed?
    end

    remove_column :sites, :roof_built_at
    remove_column :sites, :insurance_company
    remove_column :sites, :mortgage_company
    remove_column :sites, :loan_tracking_number
    remove_column :sites, :claim_number
    remove_column :contracts, :construction_start_at
    remove_column :contracts, :construction_end_at
    remove_column :contracts, :construction_payment_at
    remove_column :projects, :cost
    remove_column :projects, :color
    remove_column :projects, :material
    remove_column :job_submissions, :price_per_square
    remove_column :job_submissions, :depreciation_recoverable
    remove_column :job_submissions, :roof_rcv
    remove_column :job_submissions, :roof_acv
    remove_column :job_submissions, :initial_payment
    remove_column :job_submissions, :initial_payment_date
    remove_column :job_submissions, :completion_payment
    remove_column :job_submissions, :completion_payment_date
    remove_column :job_submissions, :submitted_at
    remove_column :job_submissions, :build_type
    remove_column :job_submissions, :deductible_paid_date
    remove_column :job_submissions, :mortgage_inspection_date
    remove_column :job_submissions, :supplement_required
    remove_column :job_submissions, :supplement_notes
    remove_column :job_submissions, :roof_total
    remove_column :job_submissions, :deposit_check_amount
  end

  def down
    add_column :sites, :roof_built_at, :date
    add_column :sites, :insurance_company, :string
    add_column :sites, :mortgage_company, :string
    add_column :sites, :loan_tracking_number, :string
    add_column :sites, :claim_number, :string
    add_column :contracts, :construction_start_at, :datetime
    add_column :contracts, :construction_end_at, :datetime
    add_column :contracts, :construction_payment_at, :datetime
    add_column :projects, :cost, :decimal, precision: 10, scale: 2
    add_column :projects, :color, :string
    add_column :projects, :material, :integer
    add_column :job_submissions, :price_per_square, :decimal, precision: 10, scale: 2
    add_column :job_submissions, :depreciation_recoverable, :boolean
    add_column :job_submissions, :roof_rcv, :decimal, precision: 10, scale: 2
    add_column :job_submissions, :roof_acv, :decimal, precision: 10, scale: 2
    add_column :job_submissions, :initial_payment, :decimal, precision: 10, scale: 2
    add_column :job_submissions, :initial_payment_date, :date
    add_column :job_submissions, :completion_payment, :decimal, precision: 10, scale: 2
    add_column :job_submissions, :completion_payment_date, :date
    add_column :job_submissions, :submitted_at, :date
    add_column :job_submissions, :build_type, :string
    add_column :job_submissions, :deductible_paid_date, :date
    add_column :job_submissions, :mortgage_inspection_date, :date
    add_column :job_submissions, :supplement_required, :boolean
    add_column :job_submissions, :supplement_notes, :text
    add_column :job_submissions, :roof_total, :decimal, precision: 10, scale: 2
    add_column :job_submissions, :deposit_check_amount, :decimal, precision: 10, scale: 2

    Site.joins(:production).where.not(productions: { roof_built_date: nil }).each do |site|
      site.update_column(:roof_built_at, site.production.roof_built_date)
    end

    Site.joins(:project).each do |site|
      project = site.project
      site.insurance_company = project.insurance_carrier
      if job_submission = project.job_submission
        site.mortgage_company = job_submission.mortgage_company
        site.loan_tracking_number = job_submission.loan_number
        site.claim_number = job_submission.claim_number
      end
      site.save if site.changed?
    end
  end
end
