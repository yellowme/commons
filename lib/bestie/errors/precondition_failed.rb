module Bestie
  module Errors
    class PreconditionFailed < ErrorBase
      def initialize(message = nil, backtrace = nil, title: nil, code: nil, detail: nil, meta: {})
        super message,
              backtrace,
              status: :precondition_failed,
              title: title || I18n.t('status_code.IER4010_precondition_failed.title'),
              code: code || I18n.t('status_code.IER4010_precondition_failed.code'),
              detail: detail || I18n.t('status_code.IER4010_precondition_failed.detail'),
              meta: meta
      end
    end
  end
end
