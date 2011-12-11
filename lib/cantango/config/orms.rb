module CanTango
  class Configuration
    class Orms < CanTango::Registry::Base
      include Singleton
    end
  end
end

