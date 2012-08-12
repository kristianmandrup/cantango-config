module CanTango
  class Config    
    module OnOff
      extend ActiveSupport::Concern
      
      included do
        attr_reader :on, :off
      end

      def on?
        @enabled == true
      end

      def off?
        !on?
      end

      def on!
        @enabled = true
      end

      def off!
        @enabled = false
      end
    end
  end
end