module CanTango
  class Config
    class Categories < CanTango::Registry::Hash
      include Singleton

      def [] label
        models = super
        return [] unless models.kind_of?(Array)
        # raise "Category '#{label}' either not exists or invalid!" if !models.kind_of?(Array)
        models
      end

      def category label, &block
        cat = CanTango::Category.new self[label]
        yield cat if block
        cat
      end

      # test if a any of the categories contain the subject
      def has_any? subject, &block
        found = registered.any? {|cat, subjects| subjects.include? subject }
        yield if found && block
        found
      end

      # find the category of a subject if such a category exists
      def category_names_of_subject subject, &block
        categories_of_subject(subject).keys
      end

      # find the category of a subject if such a category exists
      def categories_of_subject subject, &block
        found_categories = registered.select do |cat, subjects|
          subjects.include? subject.to_s
        end
        found_categories.empty? ? {} : found_categories
      end
    end
  end
end
