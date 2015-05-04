class MoveFieldsAmongTables < ActiveRecord::Migration
  def up
    add_column :productions, :paid_till_now, :decimal, precision: 10, scale: 2
    rename_column :projects, :re_roof_material, :existing_roof_material
    add_column :projects, :code_coverage_confirmed, :boolean, default: false
    add_column :projects, :po_legacy, :string
    add_column :projects, :hoa_approval_date, :date
    add_column :projects, :last_roof_built_date, :date

    Production.reset_column_information
    Project.reset_column_information

    Project.joins(:job_submission).each do |project|
      if job_submission = project.job_submission
        project.code_coverage_confirmed = job_submission.building_code_upgrade_confirmed
        project.po_legacy = job_submission.po_legacy
        project.hoa_approval_date = job_submission.hoa_approval_date
        project.save
      end
    end

    Contract.joins(site: :production).where.not(contracts: { paid_till_now: nil }).each do |contract|
      if production = contract.site.production
        production.update_column(:paid_till_now, contract.paid_till_now)
      end
    end

    remove_column :contracts, :paid_till_now
    remove_column :job_submissions, :building_code_upgrade_confirmed
    remove_column :job_submissions, :po_legacy
    remove_column :job_submissions, :hoa_approval_date
  end

  def down
    add_column :contracts, :paid_till_now, :decimal, precision: 10, scale: 2
    rename_column :projects, :existing_roof_material, :re_roof_material
    add_column :job_submissions, :building_code_upgrade_confirmed, :boolean, default: false
    add_column :job_submissions, :po_legacy, :string
    add_column :job_submissions, :hoa_approval_date, :date
    add_column :job_submissions, :last_roof_built_date, :date

    Contract.reset_column_information
    JobSubmission.reset_column_information

    Project.joins(:job_submission).each do |project|
      if job_submission = project.job_submission
        job_submission.building_code_upgrade_confirmed = project.code_coverage_confirmed
        job_submission.po_legacy = project.po_legacy
        job_submission.hoa_approval_date = project.hoa_approval_date
        job_submission.save
      end
    end

    Production.where.not(productions: { paid_till_now: nil }).each do |production|
      if contract = production.site.contract
        contract.update_column(:paid_till_now, production.paid_till_now)
      end
    end

    remove_column :productions, :paid_till_now
    remove_column :projects, :code_coverage_confirmed
    remove_column :projects, :po_legacy
    remove_column :projects, :hoa_approval_date
  end
end
