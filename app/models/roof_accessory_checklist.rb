class RoofAccessoryChecklist < ActiveRecord::Base
  audited
  ACCESS = { 1 => 'Good', 2 => 'Bad', 3 => 'N/A' }

  belongs_to :project
  has_many :skylights, dependent: :destroy

  accepts_nested_attributes_for :skylights, allow_destroy: true, reject_if: lambda {|q| q.reject{|k,v| k == '_destroy'}.values.all?(&:blank?)}
end