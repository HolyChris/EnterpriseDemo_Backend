class Customer < ActiveRecord::Base
  audited
  acts_as_paranoid

  has_many :addresses, dependent: :destroy
  has_many :sites, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy
  belongs_to :bill_address, class_name: Address

  validates :firstname, :lastname, :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: EMAIL_REGEXP }, allow_blank: true

  accepts_nested_attributes_for :bill_address, reject_if: :all_blank #proc { |attributes| attributes.values.all?(&:blank?) }
  accepts_nested_attributes_for :addresses

  def fullname
    [firstname, lastname].join(' ')
  end
end