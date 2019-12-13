module Bestie
  class BaseRepository
    include Singleton

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
    # @param [Array<Hash>] params Listado de parámetros del objeto
    #
    # @return [Object] Objeto creado
    #
    # @raises [ActiveRecord::RecordInvalid]
    #
    def create!(params)
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
    def update!(id:, **params)
      object = @db_client.find_by!(id: id)
      object.update!(params)

      object
    end

    private

    def initialize
      model_name = self.class.to_s.gsub("Repository", "")
      @db_client ||= Object.const_get model_name
    end
  end
end
