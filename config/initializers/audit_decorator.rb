Audited::Adapters::ActiveRecord::Audit.class_eval do
  scope :by_user, -> (user) { where(user_type: 'User', user_id: user.id) }
  scope :created, -> { where(action: 'create') }
end