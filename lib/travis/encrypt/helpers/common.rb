module Travis
  module Encrypt
    module Helpers
      module Common
        module ClassMethods
          def attr_encrypted(*names)
            options = names.last.is_a?(Hash) ? names.pop : {}
            define_encrypted_accessors(names, options)
          end

          def define_encrypted_accessors(names, options)
            names.each do |name|
              define_encrypted_accessor(name, options)
            end
          end

          def define_encrypted_accessor(name, options)
            define_method(name) do
              Encrypt.decrypt(self[name], options)
            end

            define_method(:"#{name}=") do |string|
              self[name] = Encrypt.encrypt(string, options)
            end
          end
        end
      end
    end
  end
end
