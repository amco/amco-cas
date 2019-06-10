require 'amco/cas/engine'
require 'amco/cas/redis_ticket_store'
require 'amco/cas/filter'
require 'amco/cas/session'

module Amco
  module Cas
    mattr_accessor :settings_class_name
    @@settings_class_name = 'Settings'

    class << self
      def configure
        yield config
      end

      def config(config = {})
        RubyCAS::Filter.setup(config)
      end

      def settings_class
        @@settings_class_name.constantize
      end
    end
  end
end
