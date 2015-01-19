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
      params.permit(:cost, :priority, :insurance_carrier, :re_roof_material, :color, :material)
    end
end