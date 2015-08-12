require 'travis/encrypt/common'

module Travis
  module Encrypt
    class Encryptor
      include Common

      attr_reader :string, :key, :options

      def initialize(string, options)
        @string  = string
        @key     = options[:key] || fail("Need to pass a key")
        @options = options || {}
      end

      def apply?
        !!string && !string.empty? && !options[:disable] # TODO ask piotr
      end

      def apply
        apply? ? encrypt : string
      end

      private

        def encrypt
          iv     = create_iv
          aes    = create_aes(:encrypt, key.to_s, iv)
          string = aes.update(self.string) + aes.final
          string = add_iv(string, iv)
          string = encode(string)
          string = "#{PREFIX}#{string}" if use_prefix?
          string
        end

        def use_prefix?
          options.key?(:use_prefix) ? !!options[:use_prefix] : true
        end
    end
  end
end
