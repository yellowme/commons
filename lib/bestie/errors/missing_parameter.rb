module Bestie
  module Errors
    class MissingParameter < UnprocessableEntity
      def initialize(message = nil, param: nil)
        meta = {}
        meta.merge!(param: param.to_s.camelize(:lower)) unless param.blank?
        super message,
              detail: I18n.t('status_code.IER4007_missing_parameter.detail'),
              meta: meta
      end
    end
  end
end
