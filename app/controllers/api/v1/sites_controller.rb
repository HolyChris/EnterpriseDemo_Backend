class Api::V1::SitesController < Api::V1::BaseController
  before_action :load_site, only: [:update]
  before_filter :manage_params, only: [:create, :update]

  def create
    @site = Site.new(site_params)
    @site.save
    respond_with(@site)
  end

  def index
    @search = Site.accessible_by(current_ability, :read).ransack(search_params)
    @sites = @search.result(distinct: true).page(params[:page]).per(params[:per_page] || PER_PAGE).includes(:appointments, :assets, contract: :work_types, customer: :phone_numbers, bill_address: :state, address: :state)
    respond_with(@sites)
  end

  def update
    @site.update_attributes(site_params)
    respond_with(@site)
  end

  private
    def site_params
      params.permit(:id, :name, :contact_name, :contact_phone, :source, :source_info, :damage, :status, :bill_addr_same_as_addr, manager_ids: [], bill_address_attributes: [:id, :address1, :address2, :city, :state_id, :zipcode], address_attributes: [:id, :address1, :address2, :city, :state_id, :zipcode, :customer_id])
    end

    def search_params
      params[:q] ||= {}
      params[:q][:s] ||= 'updated_at desc'
      if params[:stage].present?
        stages = Site::STAGE_MAPPING.select{|k,v| v.downcase.delete(' ') == params[:stage].downcase.delete(' ')}.keys
        if stages.present?
          params[:q][:stage_in] = stages
          params[:q].delete(:stage_eq)
        else
          params[:q][:stage_eq] = params[:stage]
          params[:q].delete(:stage_in)
        end
      end
      params[:q]
    end

    def load_site
      unless @site = Site.accessible_by(current_ability, :update).find_by(id: params[:id])
        render_with_failure(msg: 'Site Not Found', status: 404)
      end
    end

    def manage_params
      if params[:bill_addr_same_as_addr] == '1'
        params.delete(:bill_address_attributes)
      end
    end
end