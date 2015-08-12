require 'travis/encrypt/helpers/common'

module Travis
  module Encrypt
    module Helpers
      module Sequel
        module ClassMethods
          def attr_encrypted(*names)
            options = names.last.is_a?(Hash) ? names.last : {}
            key = options[:key] || Encrypt.key
            super
            define_encrypted_values(names, key)
          end

          def define_encrypted_values(names, key)
            define_method(:values) do
              super().inject({}) do |values, (name, value)|
                value = Encrypt.decrypt(value, key: key) if names.include?(name)
                values.merge(name => value)
              end
            end
          end
        end

        def self.included(base)
          base.extend(Common::ClassMethods)
          base.extend(ClassMethods)
        end
      end
    end
  end
end
