class Api::V1::CustomerPortal::CustomersController < Api::V1::BaseController
  skip_before_action :authenticate_user_from_token!
  before_action :authenticate_customer_from_token!

  def show
    @customer, @site = @current_customer_session.customer, @current_customer_session.site
    @project = @site.project
    @managers = @site.managers.with_role(:sales_rep)
    @managers = @site.managers.with_role(:office_staff).limit(1) if @managers.blank?
    respond_with
  end
end
