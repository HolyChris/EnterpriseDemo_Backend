class User < ActiveRecord::Base
  audited
  rolify
  acts_as_paranoid
  auto_strip_attributes :firstname, :lastname

  # include Notifier
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :async

  has_many :site_managers, dependent: :destroy
  has_many :sites, through: :site_managers
  has_many :appointments

  after_save :touch_auth_token, if: "encrypted_password_changed? || sign_in_count_changed?"
  after_destroy :assign_sites_and_appointments_to_destroyer

  def assign_sites_and_appointments_to_destroyer
    if destroyer = audits.find_by(action: 'destroy').user
      site_managers.update_all(user_id: destroyer.id)
      appointments.update_all(user_id: destroyer.id)
    end
  end

  def fullname
    [firstname, lastname].compact.join(' ')
  end

  def fullname=(val)
    name = val.split(' ')
    self.firstname, self.lastname = name.shift, name.join(' ')
  end

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
