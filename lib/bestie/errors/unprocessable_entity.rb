module Bestie
  module Errors
    class UnprocessableEntity < ErrorBase
      def initialize(message = nil, backtrace = nil, title: nil, code: nil, detail: nil, meta: {})
        super message,
              backtrace,
              status: :unprocessable_entity,
              title: title || I18n.t('status_code.IER4222_unprocessable_entity.title'),
              code: code || I18n.t('status_code.IER4222_unprocessable_entity.code'),
              detail: detail || I18n.t('status_code.IER4222_unprocessable_entity.detail'),
              meta: meta
      end
    end
  end
end
