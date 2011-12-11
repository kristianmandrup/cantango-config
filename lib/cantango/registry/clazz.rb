require 'singleton'
require 'sugar-high/kind_of'

module CanTango
  module Registry
    module Clazz
      def register label, value
        raise "first arg must be a label, was: #{label}" if !label.kind_of_label?
        raise "second arg must be a valid Class, was: #{value}" if !valid? value
        name_registry.register label.to_sym
        class_registry.register value
      end
      alias_method :[]=, :register

      def << hash
        raise "Must be a hash" if !hash.is_a?(::Hash)
        hash.each_pair do |key, value|
          register key, value
        end
      end

      def registered
        name_registry.registered
      end
      alias_method :registered_names, :registered

      def clean!
        name_registry.clean!
        class_registry.clean!
      end
      alias_method :clear!, :clean!

      def registered_classes
        class_registry.registered
      end

      def registered? name
        name_registry.registered? name
      end

      def registered_class? name
        class_registry.registered? name
      end

      def name_registry
        @name_registry ||=NameRegistry.new
      end

      def class_registry
        @class_registry ||= ClassRegistry.new
      end

      def value_methods
        class_registry.value_methods
      end

      def value_types
        class_registry.types
      end

      class NameRegistry
        include CanTango::Registry::Base
      end

      class ClassRegistry
        include CanTango::Registry::Base

        def types
          [Class]
        end

        def value_methods
          []
        end
      end

      protected

      def valid? value
        valid_by_type?(value) && valid_by_methods?(value)
      end

      def valid_by_type? value
        return true if value_types.blank?
        value.any_kind_of?(*value_types)
      end

      def valid_by_methods? value
        return true if value_methods.blank?
        value_methods.all?{|m| value.respond_to(m)}
      end
    end
  end
end