class User < ActiveRecord::Base
  rolify
  # include Notifier
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :async

  private

    def add_role_sales_rep
      add_role(:sales_rep)
    end
end
