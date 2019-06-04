require 'amco/cas/engine'
require 'amco/cas/redis_ticket_store'
require 'amco/cas/filter'
require 'amco/cas/session'

module Amco
  module Cas
    class << self
      def configure
        yield config
      end

      def config(config = {})
        RubyCAS::Filter.setup(config)
      end
    end
  end
end
