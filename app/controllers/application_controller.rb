class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
    def access_denied(exception)
      reset_session
      redirect_to new_user_session_path, notice: "#{exception.message}"
    end

    def after_sign_in_path_for(resource)
      if resource.has_role?(:admin)
        admin_dashboard_path
      elsif resource.has_role?(:sales_rep)
        sales_rep_dashboard_path
      elsif resource.has_role?(:office_staff)
        office_staff_dashboard_path
      # elsif resource.has_role?(:production_rep)
      #   production_rep_dashboard_path
      # elsif resource.has_role?(:billing_rep)
      #   billing_rep_dashboard_path
      # else
      #   new_sales_rep_session_path
      end
    end
end
