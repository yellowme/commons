module Commons
  module Concerns
    module Extensions
      module Deleted
        extend ActiveSupport::Concern

        included do
          before_validation :check_not_deleted, on: [:update]

          def deleted?
            raise ActiveModel::MissingAttributeError unless self.has_attribute?(:deleted_at)
            self.deleted_at.present?
          end
        end

        private

        def check_not_deleted
          raise ActiveModel::MissingAttributeError unless self.has_attribute?(:deleted_at)
          raise ActiveRecord::RecordInvalid if self.deleted_at_in_database.present?
        end
      end
    end
  end
end
