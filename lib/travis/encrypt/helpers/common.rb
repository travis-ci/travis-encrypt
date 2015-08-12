module Travis
  module Encrypt
    module Helpers
      module Common
        module ClassMethods
          def attr_encrypted(*names)
            options = names.last.is_a?(Hash) ? names.pop : {}
            key = options[:key] || Encrypt.key

            names.each do |name|
              define_encrypted_accessor(name, key)
            end
          end

          def define_encrypted_accessor(name, key)
            define_method(name) do
              Encrypt.decrypt(self[name], key: key)
            end

            define_method(:"#{name}=") do |string|
              self[name] = Encrypt.encrypt(string, key: key)
            end
          end
        end
      end
    end
  end
end
