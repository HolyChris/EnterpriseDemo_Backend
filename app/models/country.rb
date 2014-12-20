class Country < ActiveRecord::Base
  has_many :states, -> { order('name ASC') }, dependent: :destroy
  has_many :addresses, dependent: :nullify

  validates :name, :iso_name, presence: true

  def <=>(other)
    name <=> other.name
  end

  def to_s
    name
  end

  def self.default
    find_by(name: 'United States')
  end
end
