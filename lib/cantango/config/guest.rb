module CanTango
  class Config
    class Guest
      include Singleton

      def clear!
        @user = nil
        @account = nil
      end

      def user user = nil, &block
        return (@user || guest_user) if !user && !block
        @user = user || yield
      end

      alias_method :user=, :user

      def account acc = nil, &block
        return (@account || acc) if !acc && !block
        @account = acc || yield
      end
      alias_method :account=, :account

      def default_user?
        has_guest? base_user_class
      end

      def default_account?
        has_guest? base_account_class
      end

      protected

      def guest_user
        base_user_class.guest if default_user?
      end

      def guest_account
        base_account_class.guest if default_account?
      end

      def has_guest? clazz
        clazz && defined?(clazz) && clazz.respond_to?(:guest)
      end

      def base_user_class
        CanTango.config.user.base_class
      end

      def base_account_class
        CanTango.config.account.base_class
      end
    end
  end
end
 
