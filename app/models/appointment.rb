class Appointment < ActiveRecord::Base
  audited
  acts_as_paranoid

  belongs_to :site
  belongs_to :user

  validates :date, :start_time, :site, :user, presence: true
  validate :user_is_a_site_manager, if: :user_id_changed? && :user_id? && :site_id?

  before_save :ensure_start_time_less_than_end_time, unless: 'end_time.nil?'
  alias :assigned_to :user

  def created_by
    audits.find_by(action: 'create').try(:user)
  end

  def time_range_string
    [start_time_string, end_time_string].compact.join(' - ')
  end

  def start_time_string
    convert_to_time_format(start_time) unless start_time.nil?
  end

  def start_time_string=(value)
    if value.present?
      self.start_time = convert_to_integer_format(value)
    end
  end

  def end_time_string
    convert_to_time_format(end_time) unless end_time.nil?
  end

  def end_time_string=(value)
    if value.present?
      self.end_time = convert_to_integer_format(value)
    end
  end

  def convert_to_time_format(value)
    hours, mins = value.divmod(100)
    hours += 12 if hours == 0
    if hours <= 12
      ampm = 'am'
    else
      ampm = 'pm'
      hours -= 12
    end
    "#{ sprintf('%02d', hours) }:#{ sprintf('%02d', mins) } #{ampm}"
  end

  def convert_to_integer_format(value)
    time = Time.parse(value)
    time.hour_format
  end

  private

    def ensure_start_time_less_than_end_time
      if start_time >= end_time
        errors.add(:start_time, 'should be less than end time')
        false
      end
    end

    def user_is_a_site_manager
      errors.add(:user_id, 'should be one of site managers') unless site.site_managers.where(user_id: user_id).present?
    end
end