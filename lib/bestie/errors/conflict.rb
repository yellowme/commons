module Bestie
  module Errors
    class Conflict < ErrorBase
      def initialize(message = nil, backtrace = nil, title: nil, code: nil, detail: nil, meta: {})
        super message,
              backtrace,
              status: :conflict,
              title: title || I18n.t('status_code.IER4004_conflict.title'),
              code: code || I18n.t('status_code.IER4004_conflict.code'),
              detail: detail || I18n.t('status_code.IER4004_conflict.detail'),
              meta: meta
      end
    end
  end
end
