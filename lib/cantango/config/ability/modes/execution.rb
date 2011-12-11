module CanTango
  class Config
    class Ability
      class Modes
        class Execution < CanTango::Registry::Base
          attr_writer :default_modes

          def modes
            @modes ||= [:no_cache]
          end

          def mode= mode_name
            mode_name = mode_name.to_sym
            raise ArgumentError, "Not a valid mode name" if !valid_mode_names.include? mode_name
            @modes = case mode_name
            when :all
              valid_modes
            else
              [mode_name]
            end
          end

          def default_modes
            @default_modes ||= [:cache, :no_cache]
          end

          private

          def valid_modes
            default_modes
          end
      
          def valid_mode_names
            valid_modes + [:both, :all]
          end
        end
      end
    end
  end
end