class User < ActiveRecord::Base
  audited
  rolify if Role.table_exists?
  acts_as_paranoid
  auto_strip_attributes :firstname, :lastname

  include AuthTokenMethods
  # include Notifier

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :async,
         :omniauthable, omniauth_providers: [:google_oauth2]

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

  def password_required?
    password.present? || password_confirmation.present?
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.find_by(email: data.email)
    if user
      user.provider = access_token.provider
      user.uid = access_token.uid
      user.token = access_token.credentials.token
      user.save
      user
    else
      redirect_to new_user_registration_path, notice: "Error."
    end

  end

end
