class Api::V1::ProjectsController < Api::V1::BaseController
  before_action :find_site
  before_action :find_project, only: [:update]

  def show
    @project = @site.project
    @customer = @site.customer
    respond_with(@project)
  end

  def create
    @project = Project.accessible_by(current_ability, :create).new(site_id: @site.id)
    @project.attributes = project_params
    @project.save
    @customer = @site.customer
    respond_with(@project)
  end

  def update
    @project.update_attributes(project_params)
    @customer = @site.customer
    if @project
      respond_with(@project)
    else
      render_with_failure(msg: 'project Not Found', status: 404)
    end
  end

  private
    def find_project
      unless @project = Project.accessible_by(current_ability, :update).find_by(id: params[:id], site_id: @site.id)
        render_with_failure(msg: 'project Not Found', status: 404)
      end
    end

    def project_params
      params.permit(:id, :priority, :existing_roof_material, :code_coverage_confirmed, :hoa_approval_date, :last_roof_built_date,
              :po_legacy, insurance_and_mortgage_info_attributes: [:id, :project_id, :insurance_carrier, :claim_number, :deductible,
              :loan_tracking_number, :mortgage_company], job_submission_attributes: [ :id, :project_id, :shingle_color,
              :drip_color, :shingle_manufacturer, :shingle_type, :work_type, :roof_work_rcv, :roof_work_acv,
              :roof_type_special_instructions, :initial_cost_per_sq, :roof_upgrade_cost, :roof_discount, :gutters_rcv,
              :gutters_acv, :gutters_upgrade_cost, :gutters_discount, :gutters_total, :siding_rcv, :siding_acv,
              :siding_upgrade_cost, :siding_discount, :siding_total, :windows_rcv, :windows_acv, :windows_upgrade_cost,
              :windows_discount, :windows_total, :paint_rcv, :paint_acv, :paint_upgrade_cost, :paint_discount, :paint_total,
              :hvac_rcv, :hvac_acv, :hvac_upgrade_cost, :hvac_discount, :hvac_total, :redeck ])
    end
end
