module CanTango
  class Configuration
    class Category
      def initialize *subjects
        @subjects = subjects.flatten
      end

      def subjects
        @subjects ||= []
      end

      # test if a particular category has a certain subject
      def has_any? subject, &block
        found = subjects.include? subject
        yield if found && block
        found
      end
    end
  end
end