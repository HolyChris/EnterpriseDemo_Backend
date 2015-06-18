class AssetsController < ApplicationController

  before_action :authenticate_user!

  def index
    @asset = Asset.new
  end

  def update
  end

  def create
    @asset = Attachment.new(assets_params)

    respond_to do |format|
      if @asset.save
        format.html {
          render :json => [@asset.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@asset.to_jq_upload]}, status: :created, location: @upload }
      else
        format.html { render action: "new" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

private

  def assets_params
    params.require(:asset).permit!
  end

  
end
