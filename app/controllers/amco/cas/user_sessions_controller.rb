module Amco
  module Cas
    class UserSessionsController < ApplicationController
      skip_before_action :filter_amco_id, :require_user
      protect_from_forgery

      def destroy
        return Amco::Cas::Filter.logout(self)
      end
    end
  end
end
