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
        name = name.to_s
        engines[name.to_s] if engines.available? name
      end

      def engines
        CanTango.config.engines
      end

      class Engine
        include CanTango::Config::OnOff

        attr_reader :engine_class

        def initialize engine_class
          @engine_class = engine_class
          on!
        end
      end
    end
  end
end