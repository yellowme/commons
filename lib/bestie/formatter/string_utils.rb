module Bestie
  module Formatter
    module StringUtils
      def self.capitalize(text)
        text.downcase.gsub(/(?!(las?|del?|los?|y)\b)\b\p{L}/, &:upcase)
      end
    end
  end
end
