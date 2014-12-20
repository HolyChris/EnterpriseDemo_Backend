class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      set_admin_privileges(user)
    else
      set_sales_rep_privileges(user)
    end
  end

  private

    def set_admin_privileges(user)
      can :manage, :all
    end

    def set_sales_rep_privileges(user)
      can :read, ActiveAdmin::Page, name: "Dashboard"
      can :read, ActiveAdmin::Page, name: "Settings"
      can :read, ActiveAdmin::Page, name: "Customer"
      can :manage, Customer
    end
end
