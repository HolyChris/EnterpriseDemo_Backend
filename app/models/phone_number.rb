class PhoneNumber < ActiveRecord::Base
  audited
  belongs_to :customer

  validates :number, :customer_id, presence: true
end