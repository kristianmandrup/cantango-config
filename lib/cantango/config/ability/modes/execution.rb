module CanTango
  class Config
    class Ability
      class Modes
        class Execution < CanTango::Registry::Base
          include Singleton
          
          def default
            @default ||= [:no_cache]
          end
          
          def available
            [:cache, :no_cache]
          end
        end
      end
    end
  end
end