require 'travis/encrypt/helpers/common'

module Travis
  module Encrypt
    module Helpers
      module Sequel
        module ClassMethods
          def attr_encrypted(*names)
            options = names.last.is_a?(Hash) ? names.pop : {}
            super
            define_encrypted_values(names, options)
          end

          def define_encrypted_values(names, options)
            define_method(:values) do
              super().inject({}) do |values, (name, value)|
                value = Encrypt.decrypt(value, options) if names.include?(name)
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
