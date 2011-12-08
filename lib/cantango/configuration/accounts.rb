module CanTango
  class Configuration
    class Accounts < Registry::Clazz
      include Singleton

      def register_account clazz
        register account_name(clazz), clazz
        self
      end
      alias_method :register_class, :register_account

      protected
      
      def account_name clazz
        clazz.name.demodulize.gsub(/(.+)Account$/, '\1').to_s.underscore
      end      
    end
  end
end

