class Api::V1::InsuranceAdjustorsController < Api::V1::BaseController

  before_action :find_site
  before_action :find_insurance_adjustor, only: [:update]

  def show
    if @insurance_adjustor = @site.insurance_adjustor
      @customer = @site.customer
      respond_with(@insurance_adjustor)
    else
      render_with_failure(msg: 'Adjustor Not Found', status: 404)
    end
  end

  def create
    @insurance_adjustor = InsuranceAdjustor.accessible_by(current_ability, :create).new(site_id: @site.id)
    @insurance_adjustor.attributes = adjustor_params
    @insurance_adjustor.save
    @customer = @site.customer
    respond_with(@insurance_adjustor)
  end

  def update
    @insurance_adjustor.update_attributes(adjustor_params)
    @customer = @site.customer
    respond_with(@insurance_adjustor)
  end

  private
  def find_insurance_adjustor
    unless @insurance_adjustor = InsuranceAdjustor.accessible_by(current_ability, :update).find_by(id: params[:id], site_id: @site.id)
      render_with_failure(msg: 'Adjustor Not Found', status: 404)
    end
  end

  def adjustor_params
    params.permit(:name, :email, :telephone)
  end

end
