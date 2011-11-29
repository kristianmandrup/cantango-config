module CanTango
  class Configuration
    class Models
      class MongoMapper < Mongo
        def models
          MongoMapper.database.collections
        end
      end
    end
  end
end
