class CanTango::Config::Engines
  module Available
    def available
      registered_names
    end

    def available? name
      available.include? name.to_s
    end

    def all state, &block
      if block_given?
        available.each do |name| 
          engine = engine(name)
          yield engine.engine_class if engine.is?(state)
        end
      else
        available.map do |name| 
          engine = engine(name)
          engine.engine_class if engine.is?(state)
        end.compact
      end
    end

    def any? state
      available.any? do |name| 
        engine(name).is?(state) if available?(name)
      end
    end
  end
end