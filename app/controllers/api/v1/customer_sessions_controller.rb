class Api::V1::CustomerSessionsController < ActionController::Base
  respond_to :json

  before_filter :ensure_page_token_exist, only: [:create, :new]
  before_filter :set_customer, only: [:create, :new]

  def new
    render json: { customer: {name: @customer.name} }
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
end
