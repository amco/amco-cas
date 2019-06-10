require 'casclient'

module Amco
  module Cas
    class RedisTicketStore < ::CASClient::Tickets::Storage::AbstractTicketStore
      def initialize config={}
      end

      def read_service_session_lookup st
        raise CASException, "No service_ticket specified." if st.nil?
        st = st.ticket if st.kind_of? CASClient::ServiceTicket
        session = Amco::Cas::Session.find(st)
        session.session_id
      end

      def store_service_session_lookup(st, controller)
        raise CASException, "No service_ticket specified." if st.nil?
        raise CASException, "No controller specified." if controller.nil?

        sid = session_id_from_controller(controller)
        st = st.ticket if st.kind_of? CASClient::ServiceTicket
        id_session = Amco::Cas::Session.new(ticket: st, session_id: sid, email: controller.session[:current_user_id])
        id_session.save
      end

      def cleanup_service_session_lookup(st)
        raise CASException, "No service_ticket specified." if st.nil?
        st = st.ticket if st.kind_of? CASClient::ServiceTicket
        session = Amco::Cas::Session.find(st)
        session.destroy
      end

      def process_single_sign_out st
        session_id = read_service_session_lookup(st)

        if session_id
          if session = Rails.cache.read(session_key(session_id))
            Rails.cache.delete session_key(session_id)
          else
            Rails.logger.debug "Data for session #{st.inspect} was not found. It may have already been cleared by a local CAS logout request."
          end
          cleanup_service_session_lookup(st)
          Rails.logger.info("Single-sign-out for session #{session_id.inspect} with ticket #{st.inspect} completed successfuly.")
        else
          Rails.logger.debug "Data for session #{st.inspect} was not found. It may have already been cleared by a local CAS logout request."
        end
      end

      private

      def session_key id
        "_session_id:#{id}"
      end
    end
  end
end
