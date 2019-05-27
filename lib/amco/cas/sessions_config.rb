require 'redis'

module Amco
  module Cas
    module SessionsConfig
      include ActiveSupport::Concern

      def database
        @db ||= ::Redis.new(db_config)
      end

      private

      def db_config
        @config ||= Settings.amco_id.symbolize_keys[:session_db]
      end
    end
  end
end
