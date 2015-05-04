class CreateInsuranceAndMortgageInfo < ActiveRecord::Migration
  def up
    create_table :insurance_and_mortgage_infos do |t|
      t.references :project
      t.string :insurance_carrier
      t.string :claim_number
      t.string :mortgage_company
      t.string :loan_tracking_number
      t.decimal :deductible, precision: 10, scale: 2
      t.datetime :deleted_at

      t.timestamps
    end

    Project.all.each do |project|
      insurance_and_mortgage_info = project.build_insurance_and_mortgage_info
      insurance_and_mortgage_info.insurance_carrier = project.insurance_carrier
      if job_submission = project.job_submission
        insurance_and_mortgage_info.claim_number = job_submission.claim_number
        insurance_and_mortgage_info.loan_tracking_number = job_submission.loan_number
        insurance_and_mortgage_info.mortgage_company = job_submission.mortgage_company
        insurance_and_mortgage_info.deductible = job_submission.deductible
      end
      insurance_and_mortgage_info.save
    end

    remove_column :projects, :insurance_carrier
    remove_column :job_submissions, :claim_number
    remove_column :job_submissions, :loan_number
    remove_column :job_submissions, :mortgage_company
    remove_column :job_submissions, :deductible
  end

  def down
    add_column :projects, :insurance_carrier, :string
    add_column :job_submissions, :claim_number, :string
    add_column :job_submissions, :loan_number, :string
    add_column :job_submissions, :mortgage_company, :string
    add_column :job_submissions, :deductible, :decimal, precision: 10, scale: 2

    Project.reset_column_information
    JobSubmission.reset_column_information

    Project.joins(:insurance_and_mortgage_info).each do |project|
      if insurance_and_mortgage_info = project.insurance_and_mortgage_info
        project.insurance_carrier = insurance_and_mortgage_info.insurance_carrier
        if job_submission = project.job_submission
          job_submission.claim_number = insurance_and_mortgage_info.claim_number
          job_submission.loan_number = insurance_and_mortgage_info.loan_tracking_number
          job_submission.mortgage_company = insurance_and_mortgage_info.mortgage_company
          job_submission.deductible = insurance_and_mortgage_info.deductible
          job_submission.save
        end
        project.save
      end
    end

    drop_table :insurance_and_mortgage_infos
  end
end
