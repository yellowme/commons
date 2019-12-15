module Commons
  module Concerns
    module Validations
      module Undestroyable
        extend ActiveSupport::Concern
        included do
          before_destroy :prevent_destroy
        end

        private

        def prevent_destroy
          raise Commons::Errors::Unauthorized
        end
      end
    end
  end
end
