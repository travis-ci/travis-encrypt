require 'travis/encrypt/helpers/common'

module Travis
  module Encrypt
    module Helpers
      module ActiveRecord
        def self.included(base)
          base.extend(Common::ClassMethods)
        end
      end
    end
  end
end
