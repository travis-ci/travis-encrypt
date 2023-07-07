# frozen_string_literal: true

module Travis
  module Encrypt
    class Base
      attr_reader :string, :key, :options

      def initialize(string, options)
        @string  = string
        @key     = options[:key]
        @options = options
        validate
      end

      def create_aes(mode = :encrypt, key, iv) # rubocop:disable Style/OptionalArguments
        key = key[0, 32] # https://github.com/ruby/ruby/commit/ce635262f53b760284d56bb1027baebaaec175d1
        aes = OpenSSL::Cipher.new('aes-256-cbc')
        aes.send(mode)
        aes.key = key
        aes.iv  = iv
        aes
      end

      def create_iv
        SecureRandom.hex(8)
      end

      def add_iv(string, iv)
        "#{string}#{iv}"
      end

      def extract_iv(string)
        [string[-16..], string[0..-17]]
      end

      def encode(str)
        Base64.strict_encode64(str)
      end

      def decode(str)
        Base64.strict_decode64(str)
      end

      private

      def validate
        key               || raise('No key given')
        key.is_a?(String) || raise("Invalid key given: #{key.inspect}")
      end
    end
  end
end
