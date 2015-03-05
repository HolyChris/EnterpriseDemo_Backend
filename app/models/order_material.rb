class OrderMaterial < ActiveRecord::Base
  audited
  acts_as_paranoid

  belongs_to :production

  validates :production, presence: true
end