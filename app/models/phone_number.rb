class PhoneNumber < ActiveRecord::Base
  belongs_to :customer

  validates :number, :customer_id, presence: true
end