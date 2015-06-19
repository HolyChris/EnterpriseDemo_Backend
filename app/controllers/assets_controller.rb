class AssetsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_site
  before_action :find_asset, only: [:update, :destroy]
  before_action :set_file_type, only: [:create]

  def index
    @asset = Asset.new
    respond_to do |format|
      format.html { render 'index'}
      format.json {
        @assets = @site.assets.includes(:attachments, :viewable)
        render :json => @assets.map { |asset| asset.attachments.first.to_jq_upload }.to_json 
      }
    end
    
  end

  def update
  end

  def destroy
  
  end

  def create
    @asset = @site.assets.build(asset_params)
    respond_to do |format|
      if @asset.save
        format.html {
          render :json => [@asset.attachments.first.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@asset.attachments.first.to_jq_upload]}, status: :created }
      else
        format.html { render action: "index" }
        format.json { render :json => [{:error => "custom_failure"}], :status => 304 }
      end
    end
  end

private

  def set_file_type
    if asset_params[:attachments_attributes][0][:file].content_type.match('image')
      asset_params[:type] = 'Image'
    else
      asset_params[:type] = 'Document'
      asset_params[:doc_type] = 1 # Lets set default doctype temp
    end
  end

  def asset_params
    params.require(:asset).permit!
  end

  def find_site
    @site = Site.find_by(id: params[:site_id])
    not_found unless @site
  end

  def find_asset
    @asset = @site.assets.where(id: params[:id]).first
    not_found unless @asset
  end

  
end
