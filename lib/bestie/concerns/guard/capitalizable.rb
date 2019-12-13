module Bestie
  module Concerns
    module Guard
      module Capitalizable
        extend ActiveSupport::Concern

        module ClassMethods
          attr_reader :only

          private

          def capitalize(only: [])
            @only = only
          end
        end

        included do
          before_validation :capitalize_attrs
        end

        private

        def capitalize_attrs
          self.class.only.each do |attr|
            value = self.instance_eval(attr.to_s)
            self.send("#{attr.to_s}=", Buddy::Formatter::StringUtils.capitalize(value)) unless value.nil?
          end
        end
      end
    end
  end
end
