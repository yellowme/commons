# Author: carlos@yellowme.mx
#
# Description:
# The APIError class aids us in defining a standard
# interface for how we handle the errors in our API.
#
# It has two main functions:
#   1. Hold details of the error thrown so it can
#   be translated to one of the standard HTTP codes.
#   2. Provide a consistent way to "serialize" errors.
#
# Attributes:
# - message: string, Holds a human friendly way to
# describe the error.
# - status: integer, Denotes the HTTP status code.
# - error: string, Similar to message, but this
# field is intended to show the error message from
# a raised error.
# - detail: Hash, Contains a more details about the
# error.

module Commons
  module Errors
    class ErrorBase < StandardError
      include ActiveModel::Serialization

      attr_reader :message, :backtrace, :title, :detail, :code, :meta

      def initialize(message = nil,
                     backtrace = nil,
                     status: :internal_server_error,
                     code: I18n.t('status_code.IER5000_internal_server_error.code'),
                     title: I18n.t('status_code.IER5000_internal_server_error.title'),
                     detail: I18n.t('status_code.IER5000_internal_server_error.detail'),
                     meta: {})

        @message = message
        @backtrace = backtrace
        @title = title
        @detail = detail
        @code = code
        @status = status
        @meta = meta
        @meta.merge!(message: message) unless @meta.nil? || @message.nil?
        @meta = nil if @meta.blank?
      end

      # returns the error as its hash representation
      def to_hash
        {
          code: code,
          title: title,
          status: status,
          detail: detail,
          meta: meta
        }
      end

      def status
        Rack::Utils::SYMBOL_TO_STATUS_CODE[@status]
      end
    end
  end
end
