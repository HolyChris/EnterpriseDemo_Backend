class SessionsController < Devise::SessionsController
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource)) do |format|
      format.html do
        render "sessions/new"
      end
    end
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    if resource.is_admin? || resource.is_sales_rep? || resource.is_office_staff?
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      reset_session
      redirect_to root_url
    end
  end
end