class Api::V1::InsuranceAdjustorsController < Api::V1::BaseController
  before_action :load_insurance_adjustor, only: [:update, :show]
  before_action :load_destroyable_insurance_adjustor, only: [:destroy]

  def create
    @insurance_adjustor = InsuranceAdjustor.new(adjustor_params)
    @insurance_adjustor.save
    respond_with(@insurance_adjustor)
  end

  def show
    respond_with(@insurance_adjustor)
  end

  def index
    @search = InsuranceAdjustor.accessible_by(current_ability, :read).ransack(search_params)
    @insurance_adjustors = @search.result(distinct: true).page(params[:page]).per(params[:per_page] || PER_PAGE)
    respond_with(@insurance_adjustors)
  end

  def update
    @insurance_adjustor.update_attributes(adjustor_params)
    respond_with(@insurance_adjustor)
  end

  def destroy
    if @insurance_adjustor.destroy
      render json: {success: true, status: 200}
    else
      render json: {success: false, status: 402}
    end
  end

  private
    def adjustor_params
      params[:insurance_adjustor].permit(:name, :email, :telephone)
    end

    def search_params
      params[:q] ||= {}
      params[:q][:s] ||= 'updated_at desc'
      params[:q]
    end

    def load_insurance_adjustor
      unless @insurance_adjustor = InsuranceAdjustor.accessible_by(current_ability, :update).find_by(id: params[:id])
        render_with_failure(msg: 'Adjustor Not Found', status: 404)
      end
    end

    def load_destroyable_insurance_adjustor
      unless @insurance_adjustor = InsuranceAdjustor.accessible_by(current_ability, :destroy).find_by(id: params[:id])
        render_with_failure(msg: 'Adjustor Not Found', status: 404)
      else
        unless @insurance_adjustor.sites.count.zero?
          render_with_failure(msg: 'Cannot delete this cusotmer, associated sites exists!', status: 403)
        end
      end
    end
end
