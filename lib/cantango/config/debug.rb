module CanTango
  class Config
    # Note: This config feature is currently not used, but could potentially be of use in the future
    class Debug
      include Singleton

      def set state = :on
        raise ArgumentError, "Must be :on or :off" unless !state || [:on, :off].include?(state)
        @state = state || :on
      end

      def on?
        @state == :on
      end

      def off?
        !on?
      end
      
      def debug_writer= proc
        raise ArgumentError, "Debug writer must be callable (lambda or Proc), was: #{proc}" if !callable?(proc)
        @debug_writer = proc
      end
      
      def write msg
        @debug_writer ||= Proc.new{|msg| puts msg}
        @debug_writer.call(msg)
      end
      
      protected
      
      def callable? obj
        obj && obj.respond_to?(:call)
      end      
    end
  end
end




