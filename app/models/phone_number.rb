class PhoneNumber < ActiveRecord::Base
  audited
  belongs_to :customer

  NUM_TYPE = { 1 => 'Business', 2 => 'Home', 3 => 'Mobile', 0 => 'Other' }

  validates :number, :num_type, :customer, presence: true
  validates :number, uniqueness: true
  before_save :manage_primary, if: [:primary?, :primary_changed?]

  scope :primary, -> { where(primary: true) }
  scope :secondary, -> { where(primary: false) }

  def num_type_string
    NUM_TYPE[num_type]
  end

  def number_string
    "#{number} (#{num_type_string})"
  end

  private
    def manage_primary
      customer.phone_numbers.where.not(id: id).update_all(primary: false)
    end
end