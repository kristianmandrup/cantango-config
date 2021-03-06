module CanTango
  class Config
    class Users < CanTango::Registry::Clazz
      include Singleton
      
      def register_user clazz
        register user_name(clazz), clazz
      end
      alias_method :register_class, :register_user
              
      protected
      
      def user_name clazz
        clazz.name.demodulize.gsub(/(.+)User$/, '\1').to_s.underscore
      end      
    end
  end
end

