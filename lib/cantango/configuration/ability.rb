module CanTango
  class Configuration
    class Ability
      include Singleton
      include ClassExt

      include CanTango::Configuration::Factory
      include CanTango::Configuration::ExecutionModes
      
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
      
      def factor_class_method
        :default_executor_class
      end
    end
  end
end



