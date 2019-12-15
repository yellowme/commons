module Commons
  module Errors
    class InternalServerError < ErrorBase
      def initialize(message = nil, backtrace = nil, title: nil, code: nil, detail: nil, meta: {})
        super message,
              backtrace,
              status: :internal_server_error,
              title: title || I18n.t('status_code.IER5000_internal_server_error.title'),
              code: code || I18n.t('status_code.IER5000_internal_server_error.code'),
              detail: detail || I18n.t('status_code.IER5000_internal_server_error.detail'),
              meta: meta
      end
    end
  end
end
