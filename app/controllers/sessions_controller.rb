class SessionsController < Devise::SessionsController
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource)) do |format|
      format.html do
        if params[:type].present?
          render "sessions/new/#{params[:type]}"
        else
          redirect_to root_path
        end
      end
    end
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    if unauthorized_admin?
      invalid_admin
    # elsif unauthorized_sales_rep?
      # invalid_sales_rep
    # elsif unauthorized_office_staff?
      # invalid_office_staff
    else
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  private

    # [:admin, :office_staff, :sales_rep, :production_rep, :billing_rep].each do |method_name|
    [:admin].each do |method_name|
      define_method "#{ method_name }?" do
        params[:type] == "#{ method_name }"
      end
    end

    # def invalid_office_staff
    #   reset_session
    #   redirect_to new_office_staff_session_url, alert: 'Cannot access office staff login'
    # end

    # def invalid_sales_rep
    #   reset_session
    #   redirect_to new_sales_rep_session_url, alert: 'Cannot access sales rep login'
    # end

    def invalid_admin
      reset_session
      redirect_to new_admin_session_url, alert: 'Cannot access admin login'
    end

    def unauthorized_admin?
      admin? && !resource.is_admin?
    end

    # def unauthorized_sales_rep?
    #   sales_rep? && !resource.is_sales_rep?
    # end

    # def unauthorized_office_staff?
    #   office_staff? && !resource.is_office_staff?
    # end
end