class Api::V1::ContractsController < Api::V1::BaseController
  before_action :find_site
  before_action :find_contract, only: [:update, :show]

  def show
    respond_with(@contract)
  end

  def create
    @contract = Contract.accessible_by(current_ability, :create).new(site_id: @site.id)
    @contract.attributes = contract_params
    @contract.document = attachment_obj(params[:encoded_document_data], params[:document_format]) if params[:encoded_document_data]
    @contract.ers_sign_image = attachment_obj(params[:encoded_ers_sign_image_data], params[:ers_sign_image_format]) if params[:encoded_ers_sign_image_data]
    @contract.customer_sign_image = attachment_obj(params[:encoded_customer_sign_image_data], params[:customer_sign_image_format]) if params[:encoded_customer_sign_image_data]
    @contract.save
    respond_with(@contract)
  end

  def update
    @contract.document = attachment_obj(params[:encoded_document_data], params[:document_format]) if params[:encoded_document_data]
    @contract.ers_sign_image = attachment_obj(params[:encoded_ers_sign_image_data], params[:ers_sign_image_format]) if params[:encoded_ers_sign_image_data]
    @contract.customer_sign_image = attachment_obj(params[:encoded_customer_sign_image_data], params[:customer_sign_image_format]) if params[:encoded_customer_sign_image_data]
    @contract.update_attributes(contract_params)
    respond_with(@contract)
  end

  private
    def find_contract
      unless @contract = Contract.accessible_by(current_ability, :manage).find_by(site_id: @site.id)
        render_with_failure(msg: 'Contract Not Found', status: 404)
      end
    end

    def contract_params
      params.permit(:document, :price, :notes, :special_instructions, :contract_type, :ers_sign_image, :customer_sign_image, :signed_at, work_type_ids: [])
    end
end