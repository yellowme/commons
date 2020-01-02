module Commons
  module Errors
    class ResourceNotFound < ErrorBase
      def initialize(message = nil, title: nil, code: nil, detail: nil, meta: {})
        super message,
              status: :not_found,
              title: title || I18n.t('status_code.IER4011_resource_not_found.title'),
              code: code || I18n.t('status_code.IER4011_resource_not_found.code'),
              detail: detail || I18n.t('status_code.IER4011_resource_not_found.detail'),
              meta: meta
      end
    end
  end
end
