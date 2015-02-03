class RoofAccessoryChecklist < ActiveRecord::Base
  audited
  ACCESS = {  }

  belongs_to :project
  has_many :skylights

  accepts_nested_attributes_for :skylights, allow_destroy: true, reject_if: lambda {|q| q.reject{|k,v| k == '_destroy'}.values.all?(&:blank?)}
end