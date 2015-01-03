class Api::V1::CustomersController < Api::V1::BaseController
  before_action :load_customer, only: [:update]

  def create
    @customer = Customer.new(customer_params)
    @customer.save
    respond_with(@customer)
  end

  def index
    @customers = Customer.accessible_by(current_ability, :read)
    respond_with(@customers)
  end

  def update
    @customer.update_attributes(customer_params)
    respond_with(@customer)
  end

  private
    def customer_params
      params.permit(:firstname, :lastname, :email, :spouse, :business_name, :other_business_info, bill_address_attributes: [:id, :address1, :address2, :city, :state_id, :zipcode])
    end

    def load_customer
      unless @customer = Customer.accessible_by(current_ability, :update).find_by(id: params[:id])
        render_with_failure(msg: 'Customer Not Found', status: 404)
      end
    end
end