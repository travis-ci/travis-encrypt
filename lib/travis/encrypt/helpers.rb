# frozen_string_literal: true

require 'travis/encrypt/helpers/active_record'
require 'travis/encrypt/helpers/sequel'

module Travis
  module Encrypt
    module Helpers
      def encrypt(string, options = {})
        options[:key] ||= Encrypt.key
        Encrypt.encrypt(string, options)
      end

      def decrypt(string, options = {})
        options[:key] ||= Encrypt.key
        Encrypt.decrypt(string, options)
      end
    end
  end
end
