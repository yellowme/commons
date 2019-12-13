module Bestie
  module Errors
    class ErrorSerializer < ActiveModel::Serializer
      include Bestie::Formatter::NullAttributesRemover
      type 'errors'

      attributes :status, :code, :title, :detail, :meta
    end
  end
end
