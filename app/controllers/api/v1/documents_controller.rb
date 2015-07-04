class Api::V1::DocumentsController < Api::V1::BaseController
  before_action :find_site
  before_action :find_document, only: [:update, :show]

  def index
    @search = @site.documents.ransack(search_params)
    @documents = @search.result(distinct: true).page(params[:page]).per(params[:per_page] || PER_PAGE).includes(:attachments)
    respond_with(@documents)
  end

  def create
    @document = @site.documents.build(document_params(:create))
    @document.save
    respond_with(@document)
  end

  def update
    @document.update_attributes(document_params(:update))
    respond_with(@document)
  end

  def show
    respond_with(@document)
  end

  private
    def document_params(action=:create)
      parse_encoded_attachments
      if action == :create
        params.permit(:notes, :doc_type, :title, :stage, attachments_attributes: [:file, :_destroy])
      elsif action == :update
        params.permit(:id, :notes, :doc_type, :title, :stage, attachments_attributes: [:file, :_destroy, :id])
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

    def find_document
      unless @document = @site.documents.includes(:attachments).find_by(id: params[:id])
        render_with_failure(msg: 'Document Not Found', status: 404)
      end
    end
end