class Api::V1::SessionsController < Api::V1::BaseController

  before_filter :ensure_params_exist, only: :create
  skip_before_action :authenticate_user_from_token!
 
  def create
    @resource = User.find_for_database_authentication(email: params[:email])
    return invalid_email unless @resource
    if @resource.valid_password?(params[:password])
      sign_in("user", @resource)
      respond_with(@resource)
      return
    end
    invalid_password
  end

  def destroy
    sign_out(resource_name)
  end

  protected

    def ensure_params_exist
      if params[:email].blank?
        render json: { success: false, message: "Missing email" }, status: 422
      elsif params[:password].blank?
        render json: { success: false, message: "Missing password" }, status: 422
      end
    end

    def invalid_email
      warden.custom_failure!
      render json: { success: false, message: "Invalid email" }, status: 401
    end
     
    def invalid_password
      warden.custom_failure!
      render json: { success: false, message: "Invalid password" }, status: 401
    end

end