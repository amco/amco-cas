require 'amco/cas/scope'

module Amco
  module Cas
    class Engine < ::Rails::Engine
      isolate_namespace Amco::Cas

      ActiveSupport.on_load(:action_controller) do
        include Amco::Cas::Scope
      end
    end
  end
end
