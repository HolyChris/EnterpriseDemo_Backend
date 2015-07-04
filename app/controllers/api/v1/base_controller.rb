class Api::V1::BaseController < ActionController::Base
  respond_to :json

  before_action :authenticate_user_from_token!
   
  private

    def authenticate_user_from_token!
      unless current_user
        render json: { message: 'User not authorized to perform the operation' }, status: 404
      end
    end

    # def set_request_format_json
    #   request.format = :json
    # end

    def current_user
      if auth_token && !@current_user
        if @current_user = User.find_by_auth_token(auth_token)
          @current_user = nil if @current_user.auth_token_expired?
        end
      end
      @current_user
    end

    def find_by_email
      @resource = User.find_for_database_authentication(email: params[:email])
      return invalid_email unless @resource
    end

    def invalid_email
      warden.custom_failure!
      render json: { success: false, message: "Email not found" }, status: 401
    end

    def render_with_failure(response={})
      render json: { success: false, message: response[:msg] }, status: response[:status]
    end

    def auth_token
      @auth_token ||= request.headers["X-Auth-Token"]
    end

    def find_site
      unless @site = Site.accessible_by(current_ability, :read).find_by(id: params[:site_id])
        render_with_failure(msg: 'Site Not Found', status: 404)
      end
    end

    def attachment_obj(encoded_attachment_data, attachment_format)
      if encoded_attachment_data.present?
        decoded_data = Base64.decode64(encoded_attachment_data.gsub(/\\n/, "\n").gsub(' ', '+'))
        file = Tempfile.new(["temp#{DateTime.current.to_i}", ".#{attachment_format}"]) 
        file.binmode
        file.write decoded_data
        file
      end
    end
end