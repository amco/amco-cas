require 'rubycas-client-rails'

module Amco
  module Cas
    class Filter < ::RubyCAS::Filter
      class << self
        def filter(controller)
           raise ArgumentError.new('controller param missing') if controller.nil?
          super(controller)
        end

        def logout(controller, service = nil)
          raise ArgumentError.new('controller param missing') if controller.nil?
          super(controller, service)
        end
      end
    end
  end
end
