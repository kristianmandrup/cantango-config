module CanTango
  class Configuration
    class Hooks < CanTango::Registry::Hash
      include Singleton

      def value_methods
        [:call]
      end
    end
  end
end

