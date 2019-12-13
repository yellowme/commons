module Bestie
  module Concerns
    module Validations
      module Undestroyable
        extend ActiveSupport::Concern
        included do
          before_destroy :prevent_destroy
        end

        private

        def prevent_destroy
          raise Bestie::Errors::Unauthorized
        end
      end
    end
  end
end