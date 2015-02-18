class PhoneNumber < ActiveRecord::Base
  audited
  belongs_to :customer

  validates :number, :customer, presence: true
end