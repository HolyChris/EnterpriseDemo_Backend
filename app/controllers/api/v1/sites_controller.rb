class Api::V1::SitesController < Api::V1::BaseController
  def index
    @sites = Site.accessible_by(current_ability, :read)
    respond_with(@sites)
  end
end