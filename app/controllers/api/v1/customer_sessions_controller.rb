class Api::V1::CustomerSessionsController < ActionController::Base
  respond_to :json

  before_filter :ensure_page_token_exist, only: [:create, :new]
  before_filter :set_customer, only: [:create, :new]
  before_filter :verify_po_number_and_set_site, only: :create

  def new
    render json: { customer: {name: @customer.name} }
  end

  def create
    @customer_session = @customer.customer_sessions.find_or_create_by(site: @site)
    @customer_session.touch_auth_token
    respond_with(@customer_session)
  end

  private

    def ensure_page_token_exist
      if params[:page_token].blank?
        render json: { success: false, message: "Missing token" }, status: 422
      end
    end

    def set_customer
      unless @customer = Customer.find_by(page_token: params[:page_token])
        render json: { success: false, message: "Invalid token" }, status: 422
      end
    end

    def verify_po_number_and_set_site
      if params[:po_number].blank?
        render json: { success: false, message: "Missing po_number" }, status: 422
      else
        @site = @customer.sites.find_by_po_number(params[:po_number])
        unless @site
          render json: { success: false, message: "Invalid po_number" }, status: 422
        end
      end

    end
end
