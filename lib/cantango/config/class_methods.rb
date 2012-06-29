module CanTango
  class Config
    module ClassMethods
      def self.extended base
        base.class_eval do
          components.each do |conf_module|
            class_eval %{
              def #{conf_module} &block
                conf = conf::#{conf_module.to_s.camelize}.instance
                yield conf if block
                conf
              end
            }
          end
        end
      end
      
      # :modes, :roles, :role_groups
      def components
        [
          :account, :accounts, :adapters, :autoload, :categories, 
          :debug, :engines, :guest, :helpers, :hooks, :localhosts, 
          :models, :orms, :user, :users
        ]
      end
    end
  end
end