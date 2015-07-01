class Api::V1::RegistrationsController < Api::V1::BaseController

  def update
    current_user.update_attributes(user_params)
    respond_with(current_user)
  end

private

  def user_params
    params.permit(:email, :password, :password_confirmation, :fullname)
  end
end