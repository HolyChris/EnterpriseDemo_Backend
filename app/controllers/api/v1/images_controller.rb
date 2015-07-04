class Api::V1::ImagesController < Api::V1::BaseController
  before_action :find_site
  before_action :find_image, only: [:update, :show]

  def index
    @search = @site.images.ransack(search_params)
    @images = @search.result(distinct: true).page(params[:page]).per(params[:per_page] || PER_PAGE).includes(:attachments)
    respond_with(@images)
  end

  def create
    @image = @site.images.build(image_params(:create))
    @image.save
    respond_with(@image)
  end

  def update
    @image.update_attributes(image_params(:update))
    respond_with(@image)
  end

  def show
    respond_with(@image)
  end

  private
    def image_params(action=:create)
      parse_encoded_attachments
      if action == :create
        params.permit(:notes, :stage, :title, attachments_attributes: [:file, :_destroy])
      elsif action == :update
        params.permit(:id, :notes, :stage, :title, attachments_attributes: [:file, :_destroy, :id])
      end
    end

    def search_params
      params[:q] ||= {}
      params[:q][:s] ||= 'updated_at desc'
      params[:q]
    end

    def parse_encoded_attachments
      if params[:attachments_attributes]
        params[:attachments_attributes].each do |k, v|
          if v[:encoded_attachment_data]
            encoded_attachment_data = v.delete(:encoded_attachment_data)
            attachment_format = v.delete(:attachment_format)
            v[:file] = attachment_obj(encoded_attachment_data, attachment_format)
          end
        end
      end
    end

    def find_image
      unless @image = @site.images.includes(:attachments).find_by(id: params[:id])
        render_with_failure(msg: 'Image Not Found', status: 404)
      end
    end
end