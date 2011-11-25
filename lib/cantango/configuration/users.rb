module CanTango
  class Configuration
    class Users < Registry::Candidate
      include Singleton
    end
  end
end

