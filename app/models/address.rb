class Address < ActiveRecord::Base
  belongs_to :country
  belongs_to :state
  belongs_to :customer

  before_validation :set_defaults

  validates :address1, :city, :state, :country, presence: true

  def state_text
    state.try(:abbr) || state.try(:name)
  end

  def full_address(options={})
    separator = options[:separator] || ', '
    addr = [address(options), city, state.try(:abbr)].compact.join(separator)
    [addr, zipcode].join(', ').html_safe
  end

  def address(options={})
    addr_arr = []
    addr_arr << address2
    addr_arr << address1
    addr_str = addr_arr.compact.join(', ')
    addr_str
  end

  private
    def set_defaults
      self.country_id ||= Country.default.id
    end
end
