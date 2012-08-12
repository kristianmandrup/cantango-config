module CanTango
  class Config
    class Engines
      sweetload :Order, :Available
      
      include Singleton
      include Enumerable
      include Order
      include Available

      # to act like a hash registry
      include CanTango::Registry::Hash::InstanceMethods

      def engine name, &block
        CanTango.config.ability.engine name, &block
      end

      # engine registry is a simple hash
      def register hash
        hash.each_pair do |name, engine_class|
          raise "Class must implement the CanTango::Engine API." unless self.class.valid_engine?(engine_class)
          raise "Name of engine must be a String or Symbol" if !name.kind_of_label?
          registered[name.to_s] = ability_engine(engine_class)
        end
      end
      alias_method :<<, :register

      def clear!
        each {|engine| engine.reset! }
        @registered = nil
        clear_order!
      end

      def each
        available.each {|name| yield engine(name) }
      end

      def active? name
        active.include? name.to_sym
      end

      def active_list
        available.select {|engine| engine(name).on? }
      end

      protected

      def ability_engine clazz
        CanTango::Config::Ability::Engine.new clazz
      end

      # does it implement the basic Engine API?
      def self.valid_engine? engine_class
        [:execute!, :ability].all? {|meth| engine_class.instance_methods.include? meth }
      end
    end
  end
end