require 'rubycas-client-rails'

module Amco
  module Cas
    class Filter < ::RubyCAS::Filter
      class << self
        def filter(controller)
           raise ArgumentError.new('controller param missing') if controller.nil?
          controller&.params = controller&.cas_params
          super(controller)
        end

        def logout(controller, service = nil)
          raise ArgumentError.new('controller param missing') if controller.nil?
          controller&.params = controller&.cas_params
          super(controller, service)
        end
      end
    end
  end
end
