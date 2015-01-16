class Address < ActiveRecord::Base
  audited
  acts_as_paranoid

  auto_strip_attributes :address2

  belongs_to :country
  belongs_to :state
  belongs_to :customer
  has_one :site

  before_validation :set_defaults

  validates :address1, :city, :state, :country, :zipcode, presence: true

  def state_text
    state.try(:abbr) || state.try(:name)
  end

  def full_address(options={})
    separator = options[:separator] || ', '
    addr = [address(options), city, state.try(:abbr)].compact.join(separator)
    [addr, zipcode].compact.join(', ').html_safe
  end

  def address(options={})
    addr_arr = []
    addr_arr << address2
    addr_arr << address1
    addr_arr.compact.join(', ')
  end

  private
    def set_defaults
      self.country_id ||= Country.default.id
    end
end
