class Api::V1::SitesController < Api::V1::BaseController
  before_action :load_site, only: [:update]

  def create
    @site = Site.new(site_params)
    @site.save
    respond_with(@site)
  end

  def index
    @sites = Site.accessible_by(current_ability, :read)
    respond_with(@sites)
  end

  def update
    @site.update_attributes(site_params)
    respond_with(@site)
  end

  private
    def site_params
      params.permit(:name, :manager_ids, :source, :damage, :status, :roof_built_at, :insurance_company, :claim_number, :mortgage_company, :loan_tracking_number, address_attributes: [:id, :customer_id, :address1, :address2, :city, :state_id, :zipcode])
    end

    def load_site
      unless @site = Site.accessible_by(current_ability, :update).find_by(id: params[:id])
        render_with_failure(msg: 'Site Not Found', status: 404)
      end
    end
end