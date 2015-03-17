module JqueryDatetimepickable
  extend ActiveSupport::Concern

  module ClassMethods
    def jquery_datetimepickable(options={})
      raise ArgumentError, "Hash expected, got #{options.class.name}" unless options.is_a?(Hash)
      class_attribute :pickable_config, :pickable_col_ref
      self.pickable_config = options
      self.pickable_col_ref = pickable_config[:column].to_s

      self.class_eval do
        define_method "#{pickable_col_ref}_string".to_sym do
          if value = self.send("#{pickable_col_ref}")
            value.send(:to_s, :day_month_year_time)
          end
        end

        define_method "#{pickable_col_ref}_string=".to_sym do |value|
          self.send("#{pickable_col_ref}=", value)
        end
      end
    end
  end
end