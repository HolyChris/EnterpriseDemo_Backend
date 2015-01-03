class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      set_admin_privileges(user)
    elsif user.has_role? :office_staff
      set_office_staff_privileges(user)
    elsif user.has_role? :sales_rep
      set_sales_rep_privileges(user)
    elsif user.has_role? :production_rep
      set_production_rep_privileges(user)
    elsif user.has_role? :billing_rep
      set_billing_rep_privileges(user)
    end
  end

  private

    def set_admin_privileges(user)
      can :manage, :all
    end

    def set_office_staff_privileges(user)
      can :manage, :all
      can_manage_self(user)
    end

    def set_sales_rep_privileges(user)
      can :read, ActiveAdmin::Page, name: "Dashboard"
      can :read, ActiveAdmin::Page, name: "Settings"
      can :read, ActiveAdmin::Page, name: "Customer"
      can :manage, Customer
      can :manage, Site, id: user.site_managers.pluck(:site_id)
      # can :manage, Address, id: Address.joins(site: :site_managers).where(site_managers: { user_id: user.id }).pluck(:id)
      can_manage_self(user)
    end

    def set_production_rep_privileges(user)
      can_manage_self(user)
    end

    def set_billing_rep_privileges(user)
      can_manage_self(user)
    end

    def can_manage_self(user)
      cannot :manage, User
      can :manage, User, id: user.id
    end
end
