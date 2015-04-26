class Api::V1::SitesController < Api::V1::BaseController
  before_action :load_site, only: [:update]
  before_filter :manage_params, only: [:create, :update]

  def create
    @site = Site.new(site_params)
    @site.save
    respond_with(@site)
  end

  def index
    @sites = Site.accessible_by(current_ability, :read).includes(:customer, :appointments, address: :state)
    respond_with(@sites)
  end

  def update
    @site.update_attributes(site_params)
    respond_with(@site)
  end

  private
    def site_params
      params.permit(:name, :contact_name, :contact_phone, :source, :damage, :status, :bill_addr_same_as_addr, :roof_built_at, :insurance_company, :claim_number, :mortgage_company, :loan_tracking_number, manager_ids: [], bill_address_attributes: [:id, :address1, :address2, :city, :state_id, :zipcode], address_attributes: [:id, :address1, :address2, :city, :state_id, :zipcode, :customer_id])
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