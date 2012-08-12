module CanTango
  class Config    
    module OnOff
      extend ActiveSupport::Concern
      
      included do
        attr_reader :state
      end

      def set state = :on
        raise ArgumentError, "Must be :on or :off" unless !state || [:on, :off].include?(state)
        @state = state || :on
      end

      def reset!
        @state = nil
      end

      def is? state
        raise ArgumentError, "Can only check on/off state" unless valid_state? state
        send("#{state}?")
      end

      def on?
        @state == true
      end

      def off?
        !on?
      end

      def on!
        @state = true
      end

      def off!
        @state = false
      end

      protected

      def valid_state? state
        [:on, :off].include? state.to_sym
      end
    end
  end
end