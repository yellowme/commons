module Commons
  module Errors
    class ErrorSerializer < ActiveModel::Serializer
      include Commons::Formatter::NullAttributesRemover
      type 'errors'

      attributes :status, :code, :title, :detail, :meta
    end
  end
end
