require 'singleton'

module CanTango
  class Config
    class Ability
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

      class Engine
        include Singleton

        def set state = :on
          raise ArgumentError, "Must be :on or :off" unless !state || [:on, :off].include?(state)
          @state = state || :on
        end

        def reset!
          @state = nil
        end

        def on?
          @state == :on
        end

        def off?
          !on?
        end
      end
    end
  end
end