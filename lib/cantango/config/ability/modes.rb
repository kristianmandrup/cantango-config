module CanTango
  class Config
    class Ability
      class Modes < CanTango::Registry::Clazz
        include Singleton
        
        sweetload :Execution

        def execution
          Execution.instance
        end
      end
    end
  end
end

