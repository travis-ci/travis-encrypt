# frozen_string_literal: true

require 'base64'
require 'securerandom'
require 'openssl'
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
    end

    def encrypt(string, options)
      Encryptor.new(string, { key: Encrypt.key }.merge(options)).apply
    end

    def decrypt(string, options)
      Decryptor.new(string, { key: Encrypt.key }.merge(options)).apply
    end

    extend self
  end
end
