module CanTango
  class Config
    class Orms < CanTango::Registry::Base
      include Singleton
    end
  end
end

