module CanTango
  class Configuration
    class Ability
      include Singleton
      include ClassExt

      include CanTango::Configuration::Factory
      include CanTango::Configuration::ExecutionModes
      
      def default_class
        @default_class ||= CanTango::Ability::Executor::Modal
      end
    end
  end
end



