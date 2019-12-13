module Bestie
  module Formatter
    module NullAttributesRemover
      def attributes(*args)
        super.compact
      end
    end
  end
end
