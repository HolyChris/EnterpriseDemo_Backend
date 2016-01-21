class Api::V1::AdjustorPortal::AdjustorsController < Api::V1::BaseController
  skip_before_action :authenticate_user_from_token!

  def show
    @adjustor = InsuranceAdjustor.find_by_page_token params[:token]
    @site = @adjustor.site
    @project = @site.project
    @managers = @site.managers.with_role(:sales_rep)
    @managers = @site.managers.with_role(:office_staff).limit(1) if @managers.blank?
    respond_with
  end
end
