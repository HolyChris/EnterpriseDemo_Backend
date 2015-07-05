class Api::V1::AppointmentsController < Api::V1::BaseController
  before_action :load_appointment, only: [:update, :show]

  def index
    @appointments = Appointment.accessible_by(current_ability, :read).includes(:follow_ups)
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.save
    respond_with(@appointment)
  end

  def update
    @appointment.update_attributes(appointment_params(:update))
    respond_with(@appointment)
  end

  def show
    respond_with(@appointment)
  end

  private
    def appointment_params(action=:create)
      if action == :create
        params.permit(:scheduled_at, :outcome, :notes, :site_id, :user_id, follow_ups_attributes: [:scheduled_at, :notes, :id, :_destroy])
      elsif action == :update
        params.permit(:id, :scheduled_at, :outcome, :notes, :user_id, follow_ups_attributes: [:scheduled_at, :notes, :id, :_destroy])
      end
    end

    def load_appointment
      unless @appointment = Appointment.accessible_by(current_ability, :update).find_by(id: params[:id])
        render_with_failure(msg: 'Appointment Not Found', status: 404)
      end
    end
end