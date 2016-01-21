class InsuranceAdjustor < ActiveRecord::Base
  audited
  acts_as_paranoid

  has_secure_token :page_token
  belongs_to :project

end