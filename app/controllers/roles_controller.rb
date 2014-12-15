class RolesController < ApplicationController
  layout 'active_admin_logged_out'

  def home_page
    user = current_user || User.new
    if user.has_role? :admin
      redirect_to admin_dashboard_path
    elsif user.has_role? :sales_rep
      redirect_to sales_rep_dashboard_path
    else
      reset_session
    end
  end

end