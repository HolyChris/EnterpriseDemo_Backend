class Api::V1::ProjectsController < Api::V1::BaseController
  before_action :find_site
  before_action :find_project, only: [:update]

  def show
    @project = @site.project
    respond_with(@project)
  end

  def create
    @project = Project.accessible_by(current_ability, :create).new(site_id: @site.id)
    @project.attributes = project_params
    @project.save
    respond_with(@project)
  end

  def update
    @project.update_attributes(project_params)
    respond_with(@project)
  end

  private
    def find_site
      unless @site = Site.accessible_by(current_ability, :read).find_by(id: params[:site_id])
        render_with_failure(msg: 'Site Not Found', status: 404)
      end
    end

    def find_project
      unless @project = Project.accessible_by(current_ability, :update).find_by(id: params[:id], site_id: @site.id)
        render_with_failure(msg: 'project Not Found', status: 404)
      end
    end

    def project_params
      params.permit(:priority, :insurance_carrier, :re_roof_material, :color, :material, job_submission_attributes: [
              :id, :po_legacy, :project_id, :shingle_color, :drip_color, :shingle_manufacturer, :shingle_type, :initial_payment,
              :initial_payment_date, :completion_payment, :completion_payment_date, :submitted_at, :work_type, :claim_number,
              :build_type, :deductible, :deductible_paid_date, :roof_work_rcv, :roof_work_acv,
              :roof_type_special_instructions, :hoa_approval_date, :initial_cost_per_sq, :mortgage_company,
              :loan_number, :mortgage_inspection_date, :supplement_required, :supplement_notes, :roof_upgrade_cost,
              :roof_discount, :roof_total, :gutters_rcv, :gutters_upgrade_cost, :gutters_discount, :gutters_total,
              :siding_rcv, :siding_upgrade_cost, :siding_discount, :siding_total, :windows_rcv, :windows_upgrade_cost,
              :windows_discount, :windows_total, :paint_rcv, :paint_upgrade_cost, :paint_discount, :paint_total,
              :hvac_rcv, :hvac_upgrade_cost, :hvac_discount, :hvac_total, :deposit_check_amount,
              :building_code_upgrade_confirmed, :redeck ])
    end
end