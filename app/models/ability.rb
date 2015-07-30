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
      # cannot :manage, Customer
      # can :manage, Customer, id: (user.sites.pluck(:customer_id) + Audited::Adapters::ActiveRecord::Audit.created.by_user(user).where(auditable_type: 'Customer').pluck(:auditable_id))
      # cannot :manage, Site
      # can :manage, Site, id: (user.site_managers.pluck(:site_id) + Audited::Adapters::ActiveRecord::Audit.created.by_user(user).where(auditable_type: 'Site').pluck(:auditable_id))
    end

    def set_office_staff_privileges(user)
      can :manage, :all
      # cannot :manage, Customer
      # can :manage, Customer, id: (user.sites.pluck(:customer_id) + Audited::Adapters::ActiveRecord::Audit.created.by_user(user).where(auditable_type: 'Customer').pluck(:auditable_id))
      # cannot :manage, Site
      # can :manage, Site, id: (user.site_managers.pluck(:site_id) + Audited::Adapters::ActiveRecord::Audit.created.by_user(user).where(auditable_type: 'Site').pluck(:auditable_id))
      cannot :manage, User
      can :manage, User, id: user.id
    end

    def set_sales_rep_privileges(user)
      user_site_ids = user.site_managers.pluck(:site_id)
      user_customer_ids = user.sites.pluck(:customer_id) + Audited::Adapters::ActiveRecord::Audit.created.by_user(user).where(auditable_type: 'Customer').pluck(:auditable_id)
      cannot :manage, :all

      can :manage, ActiveAdmin::Page, name: "Dashboard"
      can :manage, ActiveAdmin::Page, name: "Settings"

      can :manage, User, id: user.id

      can :create, Customer
      can :manage, Customer, id: user_customer_ids

      can :create, Site
      can :read, Site, id: Audited::Adapters::ActiveRecord::Audit.created.by_user(user).where(auditable_type: 'Site').pluck(:auditable_id)
      can :manage, Site, id: user_site_ids

      can :create, Asset
      can :manage, Asset, id: Asset.where(viewable_type: 'Site', viewable_id: user_site_ids).pluck(:id)

      can :create, Appointment
      can :read, Appointment, id: Audited::Adapters::ActiveRecord::Audit.created.by_user(user).where(auditable_type: 'Appointment').pluck(:auditable_id)
      can :manage, Appointment, user_id: user.id

      can :create, Contract
      can :read, Contract, id: Audited::Adapters::ActiveRecord::Audit.created.by_user(user).where(auditable_type: 'Contract').pluck(:auditable_id)
      can :manage, Contract, site_id: user_site_ids

      can :create, Project
      can :read, Project, id: Audited::Adapters::ActiveRecord::Audit.created.by_user(user).where(auditable_type: 'Project').pluck(:auditable_id)
      can :manage, Project, site_id: user_site_ids

      can :read, User

      # can :manage, Address, id: Address.joins(site: :site_managers).where(site_managers: { user_id: user.id }).pluck(:id)
    end

    def set_production_rep_privileges(user)
      cannot :manage, :all
      can :manage, User, id: user.id
      can :manage, Customer
      can :manage, Site, id: user.site_managers.pluck(:site_id)
      can :manage, Appointment, user_id: user.id
      can :manage, Contract, site_id: user.site_managers.pluck(:site_id)
      can :manage, Project, site_id: user.site_managers.pluck(:site_id)
      can :manage, Production, site_id: user.site_managers.pluck(:site_id)
    end

    def set_billing_rep_privileges(user)
      cannot :manage, :all
      can :manage, User, id: user.id
      can :manage, Customer
      can :manage, Site, id: user.site_managers.pluck(:site_id)
      can :manage, Appointment, user_id: user.id
      can :manage, Contract, site_id: user.site_managers.pluck(:site_id)
      can :manage, Project, site_id: user.site_managers.pluck(:site_id)
      can :manage, Billing, site_id: user.site_managers.pluck(:site_id)
    end
end
