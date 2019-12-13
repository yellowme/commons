module Bestie
  module Errors
    class ErrorSerializer < ActiveModel::Serializer
      attributes :status, :code, :title, :detail, :meta
    end
  end
end
