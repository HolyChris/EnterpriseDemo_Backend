class Api::V2::BaseController < Api::V1::BaseController
  include JSONAPI::ActsAsResourceController

  def context
    {
        current_user: current_user,
        current_ability: current_ability
    }
  end

end

