class Customer < ActiveRecord::Base
  has_many :addresses
  has_many :sites
  belongs_to :bill_address, class_name: Address

  validates :firstname, :lastname, :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: EMAIL_REGEXP }, allow_blank: true

  accepts_nested_attributes_for :bill_address
  accepts_nested_attributes_for :addresses

  def fullname
    [firstname, lastname].join(' ')
  end
end