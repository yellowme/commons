module Commons
  module Errors
    class InvalidResource < UnprocessableEntity
      def initialize(message = nil,
                     backtrace = nil,
                     title: nil,
                     code: nil,
                     detail: nil,
                     validation_errors: nil)
        meta = {}
        meta.merge!(validation_errors: validation_errors) unless validation_errors.blank?
        super message,
              backtrace,
              title: title || I18n.t('status_code.IER4006_invalid_resource.title'),
              code: code || I18n.t('status_code.IER4006_invalid_resource.code'),
              detail: detail || I18n.t('status_code.IER4006_invalid_resource.detail'),
              meta: meta
      end
    end
  end
end
