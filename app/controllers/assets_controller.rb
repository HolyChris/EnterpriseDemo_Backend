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
        @assets = get_assets
        render :json => @assets.map { |asset| asset.attachments.first.to_jq_upload }.to_json 
      }
    end
    
  end

  def update
    respond_to do |format|
      if(@asset.update_attributes(asset_params))
        format.json { render json: {:text => "ok"}, :status => 200  }
      else
        format.json { render json: {:error => "custom_failure"}, :status => 422  }
      end
      format.html { render 'index', error: 'Item could not be deleted' }
    end
  end

  def destroy
    respond_to do |format|
      if @asset.destroy()
        format.json { render json: {:text => "ok"}, :status => 200  }
      else
        format.json { render json: {:error => "custom_failure"}, :status => 422  }
      end
      format.html { render 'index', error: 'Item could not be deleted', :status => 422 }
    end
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
        format.json { render :json => [{:error => "custom_failure"}], :status => 422 }
      end
    end
  end

private

  def set_file_type
    if asset_params[:attachments_attributes][0][:file].content_type.match('image')
      asset_params[:type] = 'Image'
    else
      asset_params[:type] = 'Document'
    end
  end

  def asset_params
    params.require(:asset).permit!
  end

  def find_asset
    @asset = @site.assets.where(id: params[:id]).first
    not_found unless @asset
  end

  def get_assets
    unless(params[:filter])
      @assets = @site.assets.includes(:attachments, :viewable)
    else
      params[:filter] == 'Image' ? @site.images.includes(:attachments, :viewable) : @site.documents.includes(:attachments, :viewable)
    end
  end

  
end
