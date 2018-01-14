module Services
  module Utils
    class IpParser
      def initialize(input)
        @input = input
      end

      def call
        validate_input

        Ip.new(address: ip_number, values: numbers)
      end

      private

      def validate_input
        # validate ip
        IPAddr.new(ip_number)

        # validate numbers
        numbers
      rescue IPAddr::InvalidAddressError, ArgumentError
        fail ::Exceptions::MalformedInputError
      end

      def ip_number
        @ip_number ||= input_tokens[0]
      end

      def numbers
        @numbers ||= input_tokens.slice(1, input_tokens.length).map { |n| Integer(n) }
      end

      def input_tokens
        @input_tokens ||= @input.split(/[:,]/)
      end
    end
  end
end