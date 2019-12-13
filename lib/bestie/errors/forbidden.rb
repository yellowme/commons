module Bestie
  module Errors
    class Forbidden < ErrorBase
      def initialize(message = nil, backtrace = nil, title: nil, code: nil, detail: nil, meta: {})
        super message,
              backtrace,
              status: :forbidden,
              title: title || I18n.t('status_code.IER4005_forbidden.title'),
              code: code || I18n.t('status_code.IER4005_forbidden.code'),
              detail: detail || I18n.t('status_code.IER4005_forbidden.detail'),
              meta: meta
      end
    end
  end
end
