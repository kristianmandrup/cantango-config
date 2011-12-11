module CanTango
  class Config
    class Ability
      sweetload :Modes, :ExecutionModes
      
      include Singleton
      include ClassExt

      include CanTango::Config::Factory

      def execution_modes
        ExecutionModes.instance
      end

      def execution_modes
        Modes.instance
      end

      
      def default_executor_class
        @default_executor_class ||= CanTango::Ability::Executor::Modal
      end

      def default_executor_class= clazz
        raise ArgumentError, "default must be a Class" if !is_class? clazz
        @default_executor_class = clazz
      end

      def default_class
        @default_class ||= CanTango::Ability::Base
      end
      
      def factory_class_method
        :default_executor_class
      end
    end
  end
end



