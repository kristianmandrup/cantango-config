require 'singleton'
require 'sugar-high/kind_of'

module CanTango
  module Registry
    class Hash
      module InstanceMethods
        def self.included base
          base.send :include, CanTango::Registry::Base
        end

        def types= *types
          raise "This is a Hash registry!"
        end

        def types
          [::Hash]
        end

        def value_methods
          []
        end

        def value_types
          []
        end

        def clean!
          registered = Hashie::Mash.new
        end
        alias_method :clear!, :clean!

        def default!
          @registered = default
        end

        def << hash
          raise "Must be a Hash" if !hash? hash
          registered.merge!(hash) and return if value_methods.empty? && value_types.empty?
          hash.each_pair do |key, value|
            registered[key] = value if value_api.all?{|m| value.respond_to(m)} && value.any_kind_of?(value_types)
          end
        end

        def [] label
          raise "Must be a label" if !label.kind_of_label?
          registered[label.to_s]
        end

        def []= label, value
          raise "Must be a label" if !label.kind_of_label?
          registered[label.to_s] = value
        end

        def register hash
          raise "Must be a hash" if !hash? hash
          registered.merge! hash
        end

        def unregister name
          @registered = {} if name == :all
          @registered.delete(name)
        end

        def registered
          @registered ||= default
        end

        def registered_names
          registered.keys
        end

        def registered_values
          registered.values
        end

        def registered? label
          registered_names.map(&:to_s).include? label.to_s
        end
        alias_method :registered_name, :registered?

        def registered_value? value
          registered_values.include? value
        end

        def default
          @default ||= Hashie::Mash.new
        end

        def default= hash
          @default = Hashie::Mash.new hash
        end
    
        protected
    
        def hash? value
          value.is_a?(::Hash)
        end
      end
      include InstanceMethods
    end
  end
end
