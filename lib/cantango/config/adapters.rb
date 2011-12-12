module CanTango
  class Config
    class Adapters < CanTango::Registry::Base
      include Singleton

      def adapter name
        raise "Unknown adapter #{name}" if !available.include? name.to_sym
        require "cantango/adapter/#{name}"
      end

      def use *names
        names.each {|name| adapter name }
      end

      def available
        [:moneta, :compiler]
      end
    end
  end
end



