module Commons
  module Concerns
    module Attributes
      module Sex
        extend ActiveSupport::Concern

        FEMALE = 'female'.freeze
        MALE = 'male'.freeze

        included do
          enum sex: {
            female: FEMALE,
            male: MALE
          }, _suffix: true
        end
      end
    end
  end
end
