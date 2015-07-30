module AuthTokenMethods
  extend ActiveSupport::Concern


  def auth_token_expired?
    auth_token_created_at? && (auth_token_created_at + AUTH_TOKEN_EXPIRATION) < Time.current
  end

  def touch_auth_token
    update_columns(auth_token: generate_auth_token, auth_token_created_at: Time.current)
  end

  private
    def generate_auth_token
      loop do
        token = Devise.friendly_token
        break token unless self.class.where(auth_token: token).first
      end
    end

end
