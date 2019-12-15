module Commons
  module Errors
    class PaymentRequired < ErrorBase
      def initialize(message = nil, backtrace = nil, title: nil, code: nil, detail: nil, meta: {})
        super message,
              backtrace,
              status: :payment_required,
              title: title || I18n.t('status_code.IER4009_payment_required.title'),
              code: code || I18n.t('status_code.IER4009_payment_required.code'),
              detail: detail || I18n.t('status_code.IER4009_payment_required.detail'),
              meta: meta
      end
    end
  end
end
