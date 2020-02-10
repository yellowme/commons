module Commons
  module Concerns
    module Extensions
      module SoftDeleted
        extend ActiveSupport::Concern

        included do

          before_validation :check_not_deleted, on: [:update]

          def deleted?
            raise ActiveModel::MissingAttributeError unless has_required_fields?
            self.deleted_at.present?
          end
        end

        def self.default_scope
          raise ActiveModel::MissingAttributeError unless has_required_fields?
          where(deleted_at: nil)
        end

        private

        def check_not_deleted
          raise ActiveModel::MissingAttributeError unless has_required_fields?
          raise ActiveRecord::RecordInvalid if self.deleted_at_in_database.present?
        end

        def has_required_fields?
          self.has_attribute?(:deleted_at)
        end
      end
    end
  end
end
