class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user!
    if (admin_request? && current_user.is_admin?) || (sales_rep_request? && current_user.is_sales_rep?) || (office_staff_request? && current_user.is_office_staff?)
      super
    else
      redirect_to after_sign_in_path_for(current_user)
    end
  end

  private
    def access_denied(exception)
      reset_session
      redirect_to new_user_session_path, notice: "#{exception.message}"
    end

    def after_sign_in_path_for(resource)
      if resource.is_admin?
        admin_dashboard_path
      elsif resource.is_sales_rep?
        sales_rep_dashboard_path
      elsif resource.is_office_staff?
        office_staff_dashboard_path
      # elsif resource.has_role?(:production_rep)
      #   production_rep_dashboard_path
      # elsif resource.has_role?(:billing_rep)
      #   billing_rep_dashboard_path
      # else
      #   new_sales_rep_session_path
      end
    end

    [:admin, :office_staff, :sales_rep].each do |role|
      define_method "#{ role }_request?" do
        !!(request.path =~ Regexp.new("/#{role}"))
      end
    end
end
