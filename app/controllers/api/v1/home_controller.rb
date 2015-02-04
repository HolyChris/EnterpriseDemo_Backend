class Api::V1::HomeController < Api::V1::BaseController
  def index
    @recent_appointments = Appointment.accessible_by(current_ability, :read).order(updated_at: :desc).limit(5)
    @recent_sites = Site.accessible_by(current_ability, :read).order(updated_at: :desc).limit(5)
    @recent_projects = Project.accessible_by(current_ability, :read).order(updated_at: :desc).limit(5)
  end
end