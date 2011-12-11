module CanTango
  class Config
    class Engines
      module Order
        def clear_order!
          @execution_order = nil
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
      end
    end
  end
end