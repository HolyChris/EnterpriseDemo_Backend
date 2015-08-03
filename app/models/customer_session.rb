class CustomerSession < ActiveRecord::Base
  include AuthTokenMethods

  belongs_to :customer
  belongs_to :site

end
