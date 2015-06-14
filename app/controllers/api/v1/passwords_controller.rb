class Api::V1::PasswordsController < Api::V1::BaseController

  skip_before_action :authenticate_user_from_token!, only: [:create]
  before_filter :find_by_email, only: [:create]

  def create
    @resource.send_reset_password_instructions
    if @resource.errors.blank?
      render json: { message: "Reset token sent successfully." }
    else
      render json: { message: "Reset token not sent." }, status: 422
    end
  end

  def update
    user = User.reset_password_by_token(resource_params)
    respond_with(user)
  end

  protected

    def resource_params
      params.permit(:reset_password_token, :password, :password_confirmation)
    end

end