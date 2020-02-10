module Commons
  module Repositories
    class BaseRepository
      include Singleton

      #
      # Método que devuelve todos los objetos activos
      #
      # @return [Arrat<Object>, nil]
      #
      delegate :all, to: :@db_client

      #
      # Método que devuelve todos los objetos que no han sido eliminados
      #
      # @return [Object,nil]
      #
      delegate :where, to: :@db_client
      alias_method :query, :where

      #
      # Método que devuelve todos los objetos que han sido eliminados
      #
      # @return [Object, nil]
      #
      def deleted
        raise ActiveModel::MissingAttributeError unless @db_client.include? Commons::Concerns::Extensions::SoftDeleted

        @db_client.unscoped.where.not(deleted_at: nil)
      end

      #
      # Método que devuelve el objeto según su ID
      #
      # @return [Object, nil]
      #
      delegate :find, to: :@db_client

      #
      # Método que devuelve el objeto según su ID
      #
      # @return [Object,nil]
      #
      def find_deleted(id)
        raise ActiveModel::MissingAttributeError unless @db_client.include? Commons::Concerns::Extensions::SoftDeleted

        @db_client.unscoped.where(id: id).where.not(deleted_at: nil).first
      end

      #
      # Método que devuelve el objeto según parámetros
      #
      # @return [Object,nil]
      #
      delegate :find_by, to: :@db_client

      #
      # Método que devuelve el objeto según parámetros
      #
      # @return [Object,nil]
      #
      def find_deleted_by(params)
        raise ActiveModel::MissingAttributeError unless @db_client.include? Commons::Concerns::Extensions::SoftDeleted

        @db_client.unscoped.where.not(deleted_at: nil).where(**params).first
      end

      #
      # Método que devuelve el objeto según parámetros
      #
      # @return [Object]
      #
      # @raise [ActiveRecord::RecordNotFound]
      #
      delegate :find_by!, to: :@db_client

      #
      # Método que devuelve el objeto según parámetros
      #
      # @return [Object]
      #
      # @raise [ActiveRecord::RecordNotFound]
      #
      def find_deleted_by!(params)
        raise ActiveModel::MissingAttributeError unless @db_client.include? Commons::Concerns::Extensions::SoftDeleted

        @db_client.unscoped.where.not(deleted_at: nil).where(**params).first!
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
        raise ArgumentError unless object.is_a?(@db_client)
        raise ActiveRecord::RecordInvalid.new(object) unless object.valid?

        save_object(object)
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
      delegate :find_or_create_by!, to: :@db_client

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
        if !object.is_a?(@db_client) || object.id.blank?
          raise ArgumentError
        end

        raise ActiveRecord::RecordInvalid.new(object) unless object.valid?

        save_object(object)
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

      #
      # Método que realiza un borrado lógico de un objeto
      #
      # @param [UUID] id Identificador del objeto
      #
      # @return [Object] Objeto eliminado
      #
      # @raises [ActiveRecord::RecordInvalid]
      # @raises [ActiveModel::MissingAttributeError]
      #
      def destroy!(object)
        if @db_client.include? Commons::Concerns::Extensions::SoftDeleted
          soft_delete!(object)
        else
          hard_delete!(object)
        end
      end

      protected

      def initialize
        @db_client = class_object
      end

      def class_object
        model_name = self.class.to_s.gsub("Repository", "")
        Object.const_get model_name
      end

      private

      def save_object(object)
        object.save
      end

      def soft_delete!(object)
        raise ActiveModel::MissingAttributeError unless @db_client.column_names.include?("deleted_at")
        object.update!(deleted_at: Time.current)

        object
      end

      def hard_delete!(object)
        object.destroy!

        object
      end
    end
  end
end
