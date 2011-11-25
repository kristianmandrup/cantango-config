require 'set'
require 'singleton'

module CanTango
  # The main entry point to configure CanTango
  class << self
    def configure &block
      conf = CanTango::Configuration.instance
      yield conf if block
      conf
    end

    alias_method :config, :configure
  end
  
  class Configuration
    autoload_modules :Categories
    autoload_modules :Models, :Engines, :Ability
    autoload_modules :Registry
    autoload_modules :Factory, :Autoload, :Adapters, :Debug, :Modes, :Orms, :Localhosts, :Hooks
    autoload_modules :Account, :Accounts
    autoload_modules :User, :Guest, :Users

    include Singleton

    def ability
      @ability ||= conf::Ability.instance
      @ability.default_class ||= CanTango::Ability::Executor::Base
      @ability
    end

    def self.components
      [
        :guest, :autoload, :user, :account, :models, :modes, :roles, :role_groups,
        :engines, :users, :accounts, :categories, :adapters, :debug,
        :localhosts, :orms, :hooks
      ]
    end

    components.each do |conf_module|
      class_eval %{
        def #{conf_module} &block
          conf = conf::#{conf_module.to_s.camelize}.instance
          yield conf if block
          conf
        end
      }
    end

    def debug!
      debug.set :on
    end

    # Turn on default engines and enable compile adapter 
    # i.e compilation of rules via sourcify
    def enable_defaults!
      engines.all :off
      adapters.use :compiler
    end

    def enable_helpers *names
      names = names.to_symbols
      enable_rest_helper if names.include? :rest
    end

    def enable_rest_helper
      raise 'ApplicationController not defined' if !defined?(::ApplicationController)
      ::ApplicationController.send :include, CanTango::Rails::Helpers::RestHelper
    end

    def clear!
      CanTango::Configuration.components.each do |component|
        if respond_to? component
          component = send(component) 
          component.send(:clear!) if component.respond_to? :clear!
        end
      end
      engines.clear!
    end

    def include_models *names
      names = names.select_symbols
      if names.include? :default_guest_user
        require 'cantango/user/guest'
      end
    end

    # allow either block or direct access
    # engine(:permission) do |permission|
    # engine(:permission).config_path
    def engine name, &block
      engine = find_engine(name)
      yield engine if block
      engine
    end

    protected

    def find_engine name
      raise ArgumentError, "Must be label for an engine" if !name.kind_of_label?
      name = name.to_s.singularize
      engines.send(name) if engines.available? name
    end

    def conf
      CanTango::Configuration
    end
  end
end
