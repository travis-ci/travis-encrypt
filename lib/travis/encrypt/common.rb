module Travis
  module Encrypt
    module Common
      def create_aes(mode = :encrypt, key, iv)
        aes = OpenSSL::Cipher::AES.new(256, :CBC)
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
        [string[-16..-1], string[0..-17]]
      end

      def encode(str)
        Base64.strict_encode64(str)
      end

      def decode(str)
        Base64.strict_decode64(str)
      end
    end
  end
end
