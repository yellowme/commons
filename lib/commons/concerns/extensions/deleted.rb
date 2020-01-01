module Commons
  module Concerns
    module Extensions
      module Deleted
        extend ActiveSupport::Concern

        included do
          def deleted?
            raise ActiveModel::MissingAttributeError unless self.has_attribute?(:deleted_at)
            self.deleted_at.present?
          end
        end
      end
    end
  end
end
