module CanTango
  class Config
    class Localhosts < CanTango::Registry::Base
      include Singleton

      def default
        @default ||= ['localhost', '0.0.0.0', '127.0.0.1']
      end
    end
  end
end