module Bestie
  module Errors
    module DefaultHandling
      def self.included(cls)
        cls.class_eval do
          # WARNING
          # Avoid setting rescue_from Exception/StandardError since it will override your
          # own custom rescue_from handlers https://stackoverflow.com/a/9121054/3287738
          # WARNING
          rescue_from ActiveRecord::RecordNotFound do |e|
            respond NotFound.new  e.message,
                                  detail: {
                                    model: e.model,
                                    id: e.id,
                                    primary_key: e.primary_key
                                  }
          end

          rescue_from ActiveRecord::RecordInvalid do |e|
            respond InvalidResource.new e.message,
                                        validation_errors: e.record.errors.to_hash
          end

          rescue_from ArgumentError do |e|
            respond InvalidResource.new e.message
          end

          rescue_from ActiveRecord::RecordNotUnique do |e|
            respond NotUnique.new e.message
          end

          rescue_from ActionController::ParameterMissing do |e|
            respond MissingParameter.new e.message, param: e.param
          end

          rescue_from ActionController::RoutingError do |e|
            respond NotFound.new  e.message,
                                  detail: { failures: e.failures }
          end
        end
      end
    end
  end
end
