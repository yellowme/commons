module Commons
  module Errors
    class Unauthorized < ErrorBase
      def initialize(message = nil, backtrace = nil, title: nil, code: nil, detail: nil, meta: {})
        super message,
              backtrace,
              status: :unauthorized,
              code: code || I18n.t('status_code.IER4002_unauthorized.code'),
              title: title || I18n.t('status_code.IER4002_unauthorized.title'),
              detail: detail || I18n.t('status_code.IER4002_unauthorized.detail'),
              meta: meta
      end
    end
  end
end
