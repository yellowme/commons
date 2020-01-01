module Commons
  module Repositories
    module Catalogs
      class BaseCatalog
        include Singleton
        include Commons::Repositories::Catalogs::Concerns::ModelCachingExtention

        #
        # Método que realiza un guardado de un objeto
        #
        # @param [Array<Hash>] params Listado de parámetros del objeto
        #
        # @return [Object] Objeto creado
        #
        # @raises [ActiveRecord::RecordInvalid]
        #
        def create_from_params!(params)
          clear_cache
          @db_client.create!(params)
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
          clear_cache
          object
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
          clear_cache

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
end
