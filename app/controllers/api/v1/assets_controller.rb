class Api::V1::AssetsController < Api::V1::BaseController
  before_action :find_site
  before_action :find_asset, only: [:update, :show, :destroy]

  def index
    @search = @site.assets.ransack(search_params)
    @assets = @search.result(distinct: true).page(params[:page]).per(params[:per_page] || PER_PAGE).includes(:attachments)
    respond_with(@assets)
  end

  def create
    p params
    @asset = @site.assets.build(asset_params(:create))
    @asset.save
    respond_with(@asset)
  end

  def update
    @asset.update_attributes(asset_params(:update))
    respond_with(@asset)
  end

  def show
    respond_with(@asset)
  end

  def destroy
    if @asset.destroy
      render json: {success: true, status: 200}
    else
      render json: {success: false, status: 402}
    end
  end

  private
    def asset_params(action=:create)
      parse_encoded_attachments
      if action == :create
        params.permit(:type, :notes, :description, :stage, :alt, attachments_attributes: [:file, :_destroy])
      elsif action == :update
        params.permit(:id, :type, :notes, :description, :stage, :alt, attachments_attributes: [:file, :_destroy, :id])
      end
    end

    def search_params
      params[:q] ||= {}
      params[:q][:s] ||= 'updated_at desc'
      params[:q]
    end

    def parse_encoded_attachments
      # if params[:attachments_attributes]
      #   params[:attachments_attributes].each do |k, v|
      #     if v[:encoded_attachment_data]
      #       encoded_attachment_data = v.delete(:encoded_attachment_data)
      #       attachment_format = v.delete(:attachment_format)
      #       v[:file] = attachment_obj(encoded_attachment_data, attachment_format)
      #     end
      #   end
      # end
    end

    def find_site
      unless @site = Site.accessible_by(current_ability, :read).find_by(id: params[:site_id])
        render_with_failure(msg: 'Site Not Found', status: 404)
      end
    end

    def find_asset
      unless @asset = @site.assets.includes(:attachments).find_by(id: params[:id])
        render_with_failure(msg: 'Asset Not Found', status: 404)
      end
    end
end