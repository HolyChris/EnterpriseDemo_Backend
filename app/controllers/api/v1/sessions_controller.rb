class Api::V1::SessionsController < Api::V1::BaseController

  before_filter :ensure_params_exist, only: :create
  skip_before_action :authenticate_user_from_token!, except: [:destroy]
  before_filter :find_by_email, only: [:create]
 
  def create
    if @resource.valid_password?(params[:password])
      sign_in("user", @resource)
      respond_with(@resource)
      return
    end
    invalid_password
  end

  def destroy
    current_user.touch_auth_token && sign_out(current_user)
    render json: { success: true, message: "Logged out" }, status: 200
  end

  protected

    def ensure_params_exist
      if params[:email].blank?
        render json: { success: false, message: "Missing email" }, status: 422
      elsif params[:password].blank?
        render json: { success: false, message: "Missing password" }, status: 422
      end
    end
     
    def invalid_password
      warden.custom_failure!
      render json: { success: false, message: "Invalid password" }, status: 401
    end

end