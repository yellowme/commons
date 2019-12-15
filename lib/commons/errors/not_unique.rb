module Commons
  module Errors
    class NotUnique < Conflict
      def initialize(message = nil, backtrace = nil, title: nil, code: nil, detail: nil, meta: {})
        super message,
              backtrace,
              title: title || I18n.t('status_code.IER4008_not_unique.title'),
              code: code || I18n.t('status_code.IER4008_not_unique.code'),
              detail: detail || I18n.t('status_code.IER4008_not_unique.detail'),
              meta: meta
      end
    end
  end
end
