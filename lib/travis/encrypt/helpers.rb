require 'travis/encrypt/helpers/active_record'
require 'travis/encrypt/helpers/sequel'

module Travis
  module Encrypt
    module Helpers
      def encrypt(string, options = {})
        Encrypt.encrypt(string, options)
      end

      def decrypt(string, options = {})
        Encrypt.decrypt(string, options)
      end
    end
  end
end
