module CanTango
  class Config
    class Models
      sweetload :Generic, :ActiveRecord, :DataMapper, :Mongo, :MongoMapper, :Mongoid
      sweetload :Actions

      include CanTango::Helpers::Debug
      include Singleton
      include ClassExt

      def use *names
        names = names.select_symbols
        if names.include? :guest_user
          require 'cantango/model/user/guest'
        end
      rescue LoadError => e
        debug e.message
      end

      def actions
        @actions ||= CanTango::Registry::Hash.new
      end

      def by_reg_exp reg_exp
        raise "Must be a Regular Expression like: /xyz/ was #{reg_exp.inspect}" if !reg_exp.kind_of? Regexp

        grep(reg_exp).map do |model_string|
          try_model(model_string)
        end
      end

      def by_category label
        categories[label].map do |model|
          model.class == String ? try_model(model) : model
        end
      end

      def exclude *names
        @excluded = names.flatten.select_labels
      end

      def excluded
        @excluded ||= []
      end

      def available
        all - excluded.map {|m| m.to_s.camelize}
      end

      protected

      def all
        CanTango.config.orms.registered.compact.inject([]) do |result, orm|
          adapter = adapter_for(orm)
          result << (adapter.available_models if adapter)
          result
        end.flatten.compact
      end

      private

      def adapter_for orm
        clazz_name = "CanTango::Configuration::Models::#{orm.to_s.camelize}"
        clazz = clazz_name.constantize
        clazz.new
      rescue Exception => e
        debug "Unknown ORM: #{orm} - no adapter defined for this ORM - #{e}"
      end

      def try_model model_string
        model = find_first_class(models_to_finds model_string) 
        raise "No model: #{models_to_finds model_string} defined!" if !model
        model
      end

      def models_to_finds model_string
        (model_string.singularize == model_string) ? model_string : [model_string.singularize, model_string]
      end
      
      # from adapter
      def grep reg_exp
        available.grep reg_exp
      end

      def categories
        CanTango.config.categories
      end
    end
  end
end

