module Commons
  module Services
    module Concerns
      module Callable
        extend ActiveSupport::Concern

        class_methods do
          def call(*args, **kwargs)
            # This approach allows thge class initializer to use regular arguments,
            # named argumets or the mix of both.
            # This at the same time allows the usage of Dry::Initializer
            # https://dry-rb.org/gems/dry-initializer/3.0/
            # And perhaps this can eventually be a defualt part of Callable Module
            new(*args, **kwargs).call
          end
        end
      end
    end
  end
end
