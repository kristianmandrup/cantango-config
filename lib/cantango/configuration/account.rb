module CanTango
  class Configuration
    class Account
      include Singleton
      include ClassExt

      def clear!
        @clazz = nil
      end

      def base_class
        @clazz ||= try_class[::UserAccount, ::Account]
      end

      def base_class= clazz
        raise ArgumentError, "Must be a class, was: #{clazz}" unless is_class? clazz
        @clazz = clazz
      end
    end
  end
end


