class Api::V1::BaseController < ActionController::Base
  respond_to :json

  before_action :authenticate_user_from_token!
   
  private

    def authenticate_user_from_token!
      unless current_user
        render json: { message: 'User not authorized to perform the operation' }, status: 404
      end
    end

    def current_user
      @current_user ||= User.find_by_auth_token(params[:auth_token]) if params[:auth_token]
    end

    def render_with_failure(response={})
      render json: { success: false, message: response[:msg] }, status: response[:status]
    end
end