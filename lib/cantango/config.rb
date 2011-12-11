require 'sugar-high/array'
require 'sugar-high/blank'
require 'hashie'
require 'set'
require 'singleton'
require 'sweetloader'

require 'cantango/core'

SweetLoader.namespaces = {:CanTango => 'cantango'}
SweetLoader.mode = :require

module CanTango
  sweetload :Registry, :ClassMethods, :Category
  extend ClassMethods

  class Config  
    sweetload :Models, :Engines, :Factory, :Ability
    sweetload :Categories
    sweetload :Autoload, :Adapters, :Debug, :Orms, :Localhosts, :Hooks, :Helpers
    sweetload :Account, :Accounts
    sweetload :User, :Guest, :Users
    sweetload :ClassMethods

    include Singleton
    extend ClassMethods

    def ability
      @ability ||= CanTango::Config::Ability.instance
      @ability.default_class ||= CanTango::Ability::Executor::Modal # from cantango-core
      @ability
    end

    def debug!
      debug.on!
    end

    # Turn on default engines and enable compile adapter 
    # i.e compilation of rules via sourcify
    def default_settings!
      engines.all :off
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
  end
end

require 'cantango/config_ext'
