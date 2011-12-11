module CanTango
  module ClassMethods
    def self.extended base
    end
    
    def configure &block
      conf = CanTango::Config.instance
      yield conf if block
      conf
    end

    alias_method :config, :configure
    # Engine hook
    # Run after the initializers are ran for all Railties (including the application itself), but before eager loading and the middleware stack is built. 
    # More importantly, will run upon every request in development, but only once (during boot-up) in production and test.
    def to_prepare
      config.hook(:to_prepare).call if config.hook(:to_prepare)
    end

    # engine hook, run after all Rails initializations have been executed
    def after_initialize
      config.hook(:after_initialize).call if config.hook(:after_initialize)
    end

    def debug!
      config.debug.set :on
    end

    def debug_off!
      config.debug.set :off
    end

    def debug?
      config.debug.on?
    end
  end
end