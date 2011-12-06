module CanTango
  class Configuration
    class Accounts < Registry::Clazz
      include Singleton

      def register_account clazz
        register account_name(clazz), clazz
      end

      protected
      
      def account_name clazz
        clazz.name.demodulize.gsub(/(.+)Account$/, '\1')..underscore
      end
      
    end
  end
end

