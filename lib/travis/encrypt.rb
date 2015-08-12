require 'securerandom'
require 'base64'
require 'travis/encrypt/decryptor'
require 'travis/encrypt/encryptor'
require 'travis/encrypt/helpers'

module Travis
  module Encrypt
    PREFIX = '--ENCR--'

    class << self
      attr_accessor :key

      def setup(config)
        self.key = config[:key]
      end

      def encrypt(string, options)
        Encryptor.new(string, options).apply
      end

      def decrypt(string, options)
        Decryptor.new(string, options).apply
      end
    end
  end
end
