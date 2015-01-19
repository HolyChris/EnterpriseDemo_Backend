class Site < ActiveRecord::Base
  module ManageStageFlow
    extend ActiveSupport::Concern

    included do
      state_machine :stage, initial: :lead do
        event :next do
          transition lead: :contract
          transition contract: :project
        end

        event :to_contract do
          transition lead: :contract
        end

        event :to_project do
          transition contract: :project
        end

        before_transition contract: :project, do: :verify_contract
      end
    end

    private
      def verify_contract
        error.add(:base, 'Contract not present') if contract.blank?
      end
  end
end