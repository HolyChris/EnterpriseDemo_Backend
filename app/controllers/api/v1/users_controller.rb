class Api::V1::UsersController < Api::V1::BaseController
  def index
    @users = User.accessible_by(current_ability, :read)
    respond_with(@users)
  end
end