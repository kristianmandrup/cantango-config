module CanTango
  class Configuration
    class Models
      class Mongoid < Mongo
        def models
          ::Mongoid.database.collections
        end
      end
    end
  end
end


