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
        end

        event :to_project do
          transition contract: :project
        end

        event :to_production do
          transition project: :production
          transition contract: :production
        end

        event :to_billing do
          transition production: :billing
          transition contract: :billing
          transition project: :billing
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