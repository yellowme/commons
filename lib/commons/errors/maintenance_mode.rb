module Commons
  module Errors
    class MaintenanceMode < ErrorBase
      def initialize(message = nil, title: nil, code: nil, detail: nil, meta: {})
        super message,
              status: :service_unavailable,
              title: title || I18n.t('status_code.IER5030_maintenance_mode.title'),
              code: code || I18n.t('status_code.IER5030_maintenance_mode.code'),
              detail: detail || I18n.t('status_code.IER5030_maintenance_mode.detail'),
              meta: meta
      end
    end
  end
end
