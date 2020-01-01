module Commons
  module Repositories
    class BaseRepository
      include Singleton

      #
      # Método que devuelve todos los objetos
      #
      # @return [Object,nil]
      #
      def all
        @db_client.all
      end

      #
      # Método que devuelve el objeto según su ID
      #
      # @return [Object,nil]
      #
      def find(id)
        @db_client.find(id)
      end

      #
      # Método que devuelve el objeto según parámetros
      #
      # @return [Object,nil]
      #
      def find_by(params)
        @db_client.find_by(params)
      end

      #
      # Método que devuelve el objeto según parámetros
      #
      # @return [Object]
      #
      # @raise [ActiveRecord::RecordNotFound]
      #
      def find_by!(params)
        @db_client.find_by!(params)
      end

      #
      # Método que realiza un guardado de un objeto
      #
      # @param [Object]
      #
      # @return [Boolean]
      #
      # @raise [ActiveRecord::RecordInvalid]
      # @raise [ActiveRecord::RecordNotSaved]
      #
      def create!(object)
        raise ArgumentError unless object.is_a? class_object

        object.save!
      end

      #
      # Método que realiza un guardado de un objeto
      #
      # @param [Array<Hash>] params Listado de parámetros del objeto
      #
      # @return [Object] Objeto creado
      #
      # @raises [ActiveRecord::RecordInvalid]
      #
      def create_from_params!(**params)
        @db_client.create!(**params)
      end

      #
      # Método que realiza una busqueda o guardado de un objeto
      #
      # @param [Array<Hash>] params Listado de parámetros del objeto
      # @param [block] block
      #
      # @return [Object] Objeto creado
      #
      # @raises [ActiveRecord::RecordInvalid]
      #
      def find_or_create_by!(params, &block)
        object = @db_client.find_by(params) || @db_client.create!(params, &block)
        object
      end

      #
      # Método que realiza una busqueda de la primer entrada,
      # en caso de no encontrarlo crea un objeto con el bloque
      #
      # @param [Array<Hash>] params Listado de parámetros del objeto
      # @param [block] block
      #
      # @return [Object] Objeto creado
      #
      # @raises [ActiveRecord::RecordInvalid]
      #
      def where_first_or_create!(params, attributes = nil, &block)
        @db_client.where(params).first_or_create!(attributes, &block)
      end

      #
      # Método que guarda los cambios realizados a una instancia del objeto
      #
      # @param [Object]
      #
      # @return [Boolean]
      #
      # @raise [ActiveRecord::RecordInvalid]
      # @raise [ActiveRecord::RecordNotSaved]
      #
      def update!(object)
        create!(object)
      end

      #
      # Método que realiza un guardado de un objeto
      #
      # @param [Array<Hash>] params Listado de parámetros del objeto
      #
      # @return [Object] Objeto creado
      #
      # @raises [ActiveRecord::RecordInvalid]
      #
      def update_from_params!(id:, **params)
        object = @db_client.find_by!(id: id)
        object.update!(params)

        object
      end

      private

      def initialize
        @db_client ||= class_object
      end

      def class_object
        model_name = self.class.to_s.gsub("Repository", "")
        Object.const_get model_name
      end
    end
  end
end
