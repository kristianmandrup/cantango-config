module CanTango::Loader
  class Yaml
    module ClassMethods
      protected

      def config_file name
        File.join(config_path, "#{name}.yml") if rails?
      end

      def config_path
        CanTango.config.permissions.config_path
      end
    end
  end
end