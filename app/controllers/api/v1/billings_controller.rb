class Api::V1::BillingsController < Api::V1::BaseController
  before_action :find_site
  before_action :find_billing, only: [:update, :show, :index]

  def show
    respond_with(@billing)
  end

  def create
    @billing = @site.build_billing(billing_params(:create))
    begin
      @billing.save
    rescue StateMachine::InvalidTransition => e
      @billing.errors.add(:base, e.message)
    end
    respond_with(@billing)
  end

  def update
    @billing.update_attributes(billing_params(:update))
    respond_with(@billing)
  end

private

  def search_params
    params[:q] ||= {}
    params[:q][:s] ||= 'updated_at desc'
    params[:q]
  end

  def billing_params(action=:create)
    if action == :create
      params.permit(:ready_for_billing_at, :initial_payment, :initial_payment_date, :final_invoice_submitted_at, :customer_invoice_notes, :invoice_send_to_manager_at, :invoice_sent_to_customer_method, :completion_payment_date, :mortgage_process_notes, :mortgage_check_location, :deductible_paid_date, :settled_rcv, :settled_rcv_date, :settled_scope_paperwork_notes, :final_check_received_amount, :check_released_date, :final_check_received_date, :invoice_sent_to_customer_at)
    elsif action == :update
      params.permit(:ready_for_billing_at, :initial_payment, :initial_payment_date, :final_invoice_submitted_at, :customer_invoice_notes, :invoice_send_to_manager_at, :invoice_sent_to_customer_method, :completion_payment_date, :mortgage_process_notes, :mortgage_check_location, :deductible_paid_date, :settled_rcv, :settled_rcv_date, :settled_scope_paperwork_notes, :final_check_received_amount, :check_released_date, :final_check_received_date, :invoice_sent_to_customer_at)
    end
  end

  def find_billing
    unless @billing = Billing.accessible_by(current_ability, :manage).find_by(site_id: @site.id)
      render_with_failure(msg: 'Billing Not Found', status: 404)
    end
  end

end