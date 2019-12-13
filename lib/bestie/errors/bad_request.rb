module Bestie
  module Errors
    class BadRequest < ErrorBase
      def initialize(message = nil, backtrace = nil, title: nil, code: nil, detail: nil, meta: {})
        super message,
              backtrace,
              status: :bad_request,
              title: title || I18n.t('status_code.IER4003_bad_request.title'),
              code: code || I18n.t('status_code.IER4003_bad_request.code'),
              detail: detail || I18n.t('status_code.IER4003_bad_request.detail'),
              meta: meta
      end
    end
  end
end
