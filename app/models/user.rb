class User < ActiveRecord::Base
  rolify
  # include Notifier
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :async

  has_many :site_managers
  has_many :sites, through: :site_managers

  before_save :ensure_authentication_token

  # def fullname
  #   [firstname, lastname].join(' ')
  # end

  private

    def ensure_authentication_token
      self.auth_token ||= generate_auth_token
    end

    def generate_auth_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(auth_token: token).first
      end
    end
end
