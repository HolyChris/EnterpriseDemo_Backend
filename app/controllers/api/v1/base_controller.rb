class Api::V1::BaseController < ActionController::Base
  respond_to :json
   
  private

    def verify_authenticity_token
      unless current_user
        render json: { message: 'User not authorized to perform the operation' }, status: 404
      end
    end

    def current_user
      if auth_token && !@current_user
        if @current_user = User.find_by_auth_token(auth_token)
          @current_user = nil if @current_user.auth_token_expired?
        end
      end
      @current_user
    end

    def render_with_failure(response={})
      render json: { success: false, message: response[:msg] }, status: response[:status]
    end

    def auth_token
      @auth_token ||= request.headers["X-Auth-Token"]
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