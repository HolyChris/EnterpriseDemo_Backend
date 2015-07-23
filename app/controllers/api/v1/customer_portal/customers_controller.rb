class Api::V1::CustomerPortal::CustomersController < Api::V1::BaseController
  skip_before_action :authenticate_user_from_token!
  before_action :authenticate_customer_from_token!

  def show
    @customer, @site = @current_customer_session.customer, @current_customer_session.site
    @project = @site.project
    respond_with
  end
end
