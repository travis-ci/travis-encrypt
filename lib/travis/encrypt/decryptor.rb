require 'travis/encrypt/base'

module Travis
  module Encrypt
    class Decryptor < Base
      def apply?
        string && (!use_prefix? || prefix_used?)
      end

      def apply
        apply? ? decrypt : string
      end

      private

        def use_prefix?
          !!options[:use_prefix]
        end

        def prefix_used?
          string[0..7] == PREFIX
        end

        def decrypt
          string   = self.string
          string   = string[8..-1] if prefix_used?
          decoded  = decode(string.to_s)
          iv, string = extract_iv(decoded)

          # A nil iv most likely means that the decoded string was not encrypted
          # to begin with, so we return the plain string.
          return string if iv.nil?

          aes = create_aes(:decrypt, key.to_s, iv)
          aes.update(string) + aes.final
        end
    end
  end
end
