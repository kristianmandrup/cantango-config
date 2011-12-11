module CanTango
  class Config
    module Factory
      def clear_factory!
        @factory = nil
      end

      def factory proc = nil
        raise ArgumentError, "Factory must be a callable (lambda or Proc), was: #{proc}" unless callable? proc
        @factory = proc
      end

      def get_factory
        @factory
      end

      alias_method :factory=, :factory

      def factory_build obj = nil, opts = {}
        factory_method = @factory ? :call_factory : :default_factory
        send(factory_method, obj, opts)
      end

      def call_factory obj = nil, opts = {}
        @factory.respond_to?(:call) ? @factory.call(obj, opts) : @factory
      end

      def default_factory obj = nil, opts = {}
        clazz_meth = send(:factory_class_method) if respond_to? :factory_class_method
        clazz_meth = :default_class unless clazz_meth && respond_to?(clazz_meth)
        raise "Default factory must be defined via call to ##{clazz_meth}" unless send(clazz_meth)
        send(clazz_meth).new obj, options.merge(opts)
      end

      attr_reader :default_class

      # must be a Class of type Cache (Base?)
      def default_class= clazz
        raise ArgumentError, "default must be a Class" if !is_class? clazz
        @default_class = clazz
      end

      def options= options = {}
        raise ArgumentError, "Must be a Hash, was #{options}" if !options.kind_of? Hash
        @options = options
      end

      def options
        @options ? type_options : type_options.merge(@options || {})
      end

      def type_options
        {}
      end

      protected

      def callable? obj
        obj && obj.respond_to?(:call)
      end
    end
  end
end


