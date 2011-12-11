module CanTango
  class Config
    class Engines
      sweetload :Order, :Available
      
      include Singleton
      include Enumerable
      include Order
      include Available
      include CanTango::Registry::Hash::InstanceMethods

      # engine registry is a simple hash
      def register hash
        hash.each_pair do |name, engine_class|
          raise "Class must implement the CanTango Engine API. You can start by sublclassing CanTango::Engine" unless self.class.valid_engine?? engine_class
          raise "Name of engine must be a String or Symbol" if !name.kind_of_label?
          registered[name.to_s] = engine_class
        end
      end

      def clear!
        each {|engine| engine.reset! }
        @registered = nil
        clear_order!
      end

      def each
        available.each {|engine| yield send(engine) if respond_to?(engine) }
      end

      def active? name
        active.include? name.to_sym
      end

      def active_list
        available.select {|engine| send(engine).on? if respond_to?(engine) }
      end

      protected

      # does it implement the basic Engine API?
      def self.valid_engine? engine_class
        [:execute!, :ability].all? {|meth| engine_class.instance_methods.include? meth }
      end
    end
  end
end