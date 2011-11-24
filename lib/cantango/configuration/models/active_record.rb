module CanTango
  class Configuration
    class Models
      class ActiveRecord < Generic
        def models
          ::ActiveRecord::Base.descendants
        rescue
          table_models
        end
        
        protected
        
        def table_models
          ActiveRecord::Base.connection.tables do |t| 
            t.classify.constantize 
            nil
          end.compact
        end
      end
    end
  end
end
