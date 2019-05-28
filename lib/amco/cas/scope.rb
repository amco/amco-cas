module Amco
  module Cas
    module Scope
      extend ActiveSupport::Concern

      included do

        before_action :filter_amco_id, :require_user

        def cas_params
          params.permit(:logoutRequest, :ticket, :renew, :id)
        end

        private

        def current_user
          @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
          @current_user
        rescue Dolly::ResourceNotFound
          @current_user = nil
          log_out
        end

        def require_user
          unless current_user
            session[:return_to] = request.fullpath unless request.xhr?
            log_out
            return false
          end
        end

        def log_out
          reset_session
          return Amco::Cas::Filter.logout(self, request.base_url)
        end

        def filter_amco_id
          Filter.filter(self)
        end
      end
    end
  end
end
