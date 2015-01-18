class Api::V1::AssetsController < Api::V1::BaseController
  before_action :find_site, only: [:create, :index, :update]
  before_action :find_asset, only: :update

  def index
    @assets = @site.assets
    respond_with(@assets)
  end

  def create
    @asset = @site.assets.build(asset_params)
    set_attachment(@asset, params[:encoded_attachment_data], params[:attachment_format])
    @asset.save
    respond_with(@asset)
  end

  def update
    set_attachment(@asset, params[:encoded_attachment_data], params[:attachment_format])
    @asset.update_attributes(asset_params)
    respond_with(@asset)
  end

  private
    def asset_params(action=:create)
      if action == :create
        params.require(:encoded_attachment_data, :site_id, :type, :notes, :description, :stage, :alt)
      elsif action == :update
        params.require(:id, :encoded_attachment_data, :site_id, :type, :notes, :description, :stage, :alt)
      end
    end

    def find_site
      unless @site = Site.accessible_by(current_ability, :read).find_by(id: params[:site_id])
        render_with_failure(msg: 'Site Not Found', status: 404)
      end
    end

    def find_asset
      unless @asset = @site.assets.find_by(id: params[:id])
        render_with_failure(msg: 'Asset Not Found', status: 404)
      end
    end
end