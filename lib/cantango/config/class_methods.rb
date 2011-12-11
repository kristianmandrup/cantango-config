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
      
      def components
        [
          :guest, :autoload, :user, :account, :models, :modes, :roles, :role_groups,
          :engines, :users, :accounts, :categories, :adapters, :debug,
          :localhosts, :orms, :hooks
        ]
      end
    end
  end
end