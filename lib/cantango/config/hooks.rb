module CanTango
  class Config
    class Hooks < CanTango::Registry::Hash
      include Singleton

      def value_methods
        [:call]
      end
    end
  end
end

