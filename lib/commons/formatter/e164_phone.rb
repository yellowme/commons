module Commons
  module Formatter
    class E164Phone
      attr_accessor :valid

      # @type [String]
      # Mexico ISO Country Code
      MEXICO_ISO_CODE = 'MX'.freeze
      # @type [String]
      # Mexico Phone Country Code
      MEXICO_CC = '52'.freeze
      # @type [String]
      # Mexico National Destination Code
      MEXICO_NDC = ''.freeze
      MEXICO_REGEX = /^(521?\d{10}|\d{10})$/
      NOT_DIGITS_REGEX = /[^0-9]/

      def initialize(phone_number)
        @phone = Phonelib.parse(phone_number)
        @valid = @phone.valid?
      end

      def format
        @valid ? @phone.e164 : nil
      end

      def format_national
        @valid ? @phone.raw_national : nil
      end

      def country_code
        @valid ? @phone.country_code : nil
      end

      def validate
        @valid && @phone.country_code == MEXICO_CC
      end

      def self.canonical_phone(phone_number)
        phone_digits = phone_number.gsub(NOT_DIGITS_REGEX, '')
        return nil unless MEXICO_REGEX.match(phone_digits)

        phone_digits.split(//).last(10).join
      end
    end
  end
end
