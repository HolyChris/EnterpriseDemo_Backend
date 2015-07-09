class Api::V1::ProductionsController < Api::V1::BaseController
  before_action :find_site
  before_action :find_production, only: [:update, :show, :index]

  def show
    respond_with(@production)
  end

  def create
    @production = @site.build_production(production_params(:create))
    begin
      @production.save
    rescue StateMachine::InvalidTransition => e
      @production.errors.add(:base, e.message)
    end
    respond_with(@production)
  end

  def update
    @production.update_attributes(production_params(:update))
    respond_with(@production)
  end

private

  def production_params(action=:create)
    if action == :create
      params.permit(:site_id, :delivery_date, :production_date, :roof_built_date, :production_inspection_date, :production_inspection_passed_date, :materials_not_used, :permit_number, :permit_date, :permit_department, :paid_till_now, :ready_for_production_at)
    elsif action == :update
      params.permit(:id, :site_id, :delivery_date, :production_date, :roof_built_date, :production_inspection_date, :production_inspection_passed_date, :materials_not_used, :permit_number, :permit_date, :permit_department, :paid_till_now, :ready_for_production_at)
    end
  end

  def find_production
    unless @production = Production.accessible_by(current_ability, :manage).find_by(site_id: @site.id)
      render_with_failure(msg: 'Production Not Found', status: 404)
    end
  end

end