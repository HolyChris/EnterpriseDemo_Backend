class User < ActiveRecord::Base
  rolify
  # include Notifier
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :async

  has_many :site_managers
  has_many :sites, through: :site_managers

  after_save :touch_auth_token, if: "encrypted_password_changed? || sign_in_count_changed?"

  # def fullname
  #   [firstname, lastname].join(' ')
  # end

  def auth_token_expired?
    auth_token_created_at? && (auth_token_created_at + AUTH_TOKEN_EXPIRATION) < Time.current
  end

  def touch_auth_token
    update_columns(auth_token: generate_auth_token, auth_token_created_at: Time.current)
  end

  def password_required?
    password.present? || password_confirmation.present?
  end

  private
    def generate_auth_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(auth_token: token).first
      end
    end
end
