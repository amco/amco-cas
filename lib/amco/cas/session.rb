require "amco/cas/sessions_config"

module Amco
  module Cas
    class Session
      extend SessionsConfig

      delegate :database, to: :class

      attr_reader :ticket, :session_id, :email

      class << self
        def find(ticket)
          parsed_values = JSON.parse(database.get(ticket))
          new parsed_values.symbolize_keys.merge({ticket: ticket})
        rescue TypeError
          nil
        end
      end

      def initialize opts = {}
        @ticket = opts[:ticket]
        @session_id = opts[:session_id]
        @email = opts[:email]
      end

      def save
        database.set ticket, values.to_json
      end

      def destroy
        database.del ticket
      end

      private

      def values
        { session_id: session_id, email: email }
      end
    end
  end
end
