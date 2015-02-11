class Api::V1::AssetsController < Api::V1::BaseController
  before_action :find_site, only: [:create, :index, :update]
  before_action :find_asset, only: :update

  def index
    @assets = @site.assets.includes(:attachments)
    respond_with(@assets)
  end

  def create
    @asset = @site.assets.build(asset_params)
    @asset.save
    respond_with(@asset)
  end

  def update
    @asset.update_attributes(asset_params)
    respond_with(@asset)
  end

  private
    def asset_params(action=:create)
      parse_encoded_attachments
      if action == :create
        params.require(:site_id, :type, :notes, :description, :stage, :alt, attachments_attributes: [:file, :_destroy])
      elsif action == :update
        params.require(:id, :site_id, :type, :notes, :description, :stage, :alt, attachments_attributes: [:file, :_destroy, :id])
      end
    end

    def parse_encoded_attachments
      if params[:attachments_attributes]
        params[:attachments_attributes].each do |k, v|
          encoded_attachment_data = v.delete(:encoded_attachment_data)
          attachment_format = v.delete(:attachment_format)
          v[:file] = attachment_obj(encoded_attachment_data, attachment_format)
        end
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