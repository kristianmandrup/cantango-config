module CanTango
  class Configuration
    class Hooks < Registry::Hash
      include Singleton
      
      def value_methods
        [:call]
      end
    end
  end
end

