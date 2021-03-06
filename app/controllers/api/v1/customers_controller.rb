class Api::V1::CustomersController < Api::V1::BaseController
  before_action :load_customer, only: [:update, :show]
  before_action :load_destroyable_customer, only: [:destroy]

  def create
    @customer = Customer.new(customer_params)
    @customer.save
    respond_with(@customer)
  end

  def show
    respond_with(@customer)
  end

  def index
    @search = Customer.accessible_by(current_ability, :read).ransack(search_params)
    @customers = @search.result(distinct: true).page(params[:page]).per(params[:per_page] || PER_PAGE).includes(:phone_numbers, sites: [ :appointments, :contract, bill_address: :state, address: :state ])
    respond_with(@customers)
  end

  def update
    @customer.update_attributes(customer_params)
    respond_with(@customer)
  end

  def destroy
    if @customer.destroy
      render json: {success: true, status: 200}
    else
      render json: {success: false, status: 402}
    end
  end

  private
    def customer_params
      params.permit(:firstname, :lastname, :email, :spouse, :business_name, :other_business_info, phone_numbers_attributes: [:number, :num_type, :primary, :id, :_destroy])
    end

    def search_params
      params[:q] ||= {}
      params[:q][:s] ||= 'updated_at desc'
      params[:q]
    end

    def load_customer
      unless @customer = Customer.accessible_by(current_ability, :update).find_by(id: params[:id])
        render_with_failure(msg: 'Customer Not Found', status: 404)
      end
    end

    def load_destroyable_customer
      unless @customer = Customer.accessible_by(current_ability, :destroy).find_by(id: params[:id])
        render_with_failure(msg: 'Customer Not Found', status: 404)
      else
        unless @customer.sites.count.zero?
          render_with_failure(msg: 'Cannot delete this cusotmer, associated sites exists!', status: 403)
        end
      end
    end
end
