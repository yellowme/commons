module Commons
  module Controllers
    module SchemaValidable
      #
      # Método que valida datos en base a un Schema
      #
      # @param [Hash] request_data datos a validar
      # @param [Dry::Validation::Contract] schema Schema de validación
      #
      # @return [Hash]
      #
      # @raise [Commons::Errors::UnprocessableEntity]
      #
      def validate_request(request_data, schema)
        validated_params = schema.call(request_data)

        if validated_params.failure?
          raise Commons::Errors::UnprocessableEntity.new(nil, nil,
            meta: { validation_errors: validated_params.errors.to_h }
          )
        end

        validated_params.to_h
      end
    end
  end
end
