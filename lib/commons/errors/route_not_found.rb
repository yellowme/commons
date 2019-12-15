module Commons
  module Errors
    class RouteNotFound < ErrorBase
      def initialize(message = nil, title: nil, code: nil, detail: nil, meta: {})
        super message,
              status: :not_found,
              title: title || I18n.t('status_code.IER4001_route_not_found.title'),
              code: code || I18n.t('status_code.IER4001_route_not_found.code'),
              detail: detail || I18n.t('status_code.IER4001_route_not_found.detail'),
              meta: meta
      end
    end
  end
end
