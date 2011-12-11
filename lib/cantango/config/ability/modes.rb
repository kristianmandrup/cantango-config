module CanTango
  class Config
    class Ability
      class Modes < CanTango::Registry::Clazz
        sweetload :Execution
        include Singleton
        
        def execution
          Execution.instance
        end
      end
    end
  end
end

