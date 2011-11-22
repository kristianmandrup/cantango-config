module CanTango
  class Configuration
    class Engines < HashRegistry
      autoload_modules :Permission, :Engine

      include Singleton
      include Enumerable

      # engine registry is a simple hash
      def register hash
        hash.each_pair do |name, engine_class|
          raise "Class must implement the CanTango Engine API. You can start by sublclassing CanTango::Engine" if !engine? engine_class
          raise "Name of engine must be a String or Symbol" if !name.kind_of_label?
          registered[name.to_s] = engine_class
        end
      end

      # defines the order of execution of engine in ability
      def set_execution_order *names        
        @execution_order = names.flatten.uniq.map(&:to_s).select {|name| available? name }
      end

      def dont_execute name
        execution_order.delete(name.to_s)
      end

      def execute_first name
        dont_execute name
        execution_order.insert(0, name.to_s)
      end

      def execute_last name
        dont_execute name
        execution_order.insert(-1, name.to_s)
      end

      def execute_before existing, name
        dont_execute name
        index = execution_order.index(existing.to_s) || 0
        execution_order.insert(index, name.to_s)
        execution_order.compact!
      end

      def execute_after existing, name
        dont_execute name
        index = execution_order.index(existing.to_s)
        index ? execution_order.insert(index +1, name.to_s) : execute_last(name)
        execution_order.compact!
      end

      def execution_order
        @execution_order ||= (available - [:cache])
      end

      def available
        registered_names
      end

      def available? name
        available.include? name.to_s
      end

      def all state
        available.each {|engine| send(engine).set state }
      end

      def any? state
        available.any? {|engine| send(engine).send(:"#{state}?") if respond_to?(engine) }
      end

      def clear!
        each {|engine| engine.reset! }
        @registered = nil
        @execution_order = nil
      end

      def each
        available.each {|engine| yield send(engine) if respond_to?(engine) }
      end

      def active? name
        active.include? name.to_sym
      end

      def active
        available.select {|engine| send(engine).on? if respond_to?(engine) }
      end

      protected

      # does it implement the basic Engine API?
      def engine? engine_class
        [:execute!, :ability].all? {|meth| engine_class.instance_methods.include? meth }
      end
    end
  end
end