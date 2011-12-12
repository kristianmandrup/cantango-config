module CanTango
  class Config
    class Accounts < CanTango::Registry::Clazz
      include Singleton

      def register_account clazz
        register account_name(clazz), clazz
        self
      end

      protected
      
      def account_name clazz
        clazz.name.demodulize.gsub(/(.+)Account$/, '\1').to_s.underscore
      end      
    end
  end
end

