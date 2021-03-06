class Site < ActiveRecord::Base
  module ManageStageFlow
    extend ActiveSupport::Concern

    included do
      state_machine :stage, initial: :lead do
        event :next do
          transition lead: :contract
          transition contract: :project
          transition project: :production
          transition production: :billing
        end

        event :to_contract do
          transition lead: :contract
          transition project: :contract
          transition production: :contract
          transition billing: :contract
          transition closed: :contract
        end

        event :to_project do
          transition contract: :project
          transition production: :project
          transition billing: :project
          transition closed: :project
        end

        event :to_production do
          transition project: :production
          transition contract: :production
          transition billing: :production
          transition closed: :production
        end

        event :to_billing do
          transition production: :billing
          transition contract: :billing
          transition project: :billing
          transition closed: :billing
        end

        event :to_closed do
          transition contract: :closed
          transition project: :closed
          transition production: :closed
          transition billing: :closed
        end

        before_transition contract: :project, do: :verify_contract
        before_transition project: :production, do: :verify_project
        before_transition production: :billing, do: :verify_production
      end
    end

    private
      def verify_contract
        errors.add(:base, 'Contract not present') if contract.blank?
      end

      def verify_project
        errors.add(:base, 'Project not present') if project.blank?
      end

      def verify_production
        errors.add(:base, 'Production not present') if production.blank?
      end
  end
end
