module Amco
  module Cas
    class UserSessionsController < ApplicationController
      skip_before_action :filter_amco_id, :require_user, only: :destroy
      protect_from_forgery except: :cas_destroy

      def destroy
        return Amco::Cas::Filter.logout(self)
      end

      def cas_destroy
        return Amco::Cas::Filter.logout(self)
      end
    end
  end
end
