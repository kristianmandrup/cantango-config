module CanTango
  class Config
    class Helpers
      include Singleton

      def enable *names
        names = names.to_symbols
        enable_rest if names.include? :rest
      end

      def enable_rest
        raise 'ApplicationController not defined' if !defined?(::ApplicationController)
        ::ApplicationController.send :include, CanTango::Rails::Helpers::RestHelper
      end
    end
  end
end