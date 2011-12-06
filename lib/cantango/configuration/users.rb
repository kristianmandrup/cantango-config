module CanTango
  class Configuration
    class Users < Registry::Clazz
      include Singleton
      
      def register_user clazz
        register user_name(clazz), clazz
      end
        
      protected
      
      def user_name clazz
        clazz.name.demodulize.gsub(/(.+)User$/, '\1')..underscore
      end      
    end
  end
end

