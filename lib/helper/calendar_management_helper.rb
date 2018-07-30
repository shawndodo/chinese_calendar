module CalendarManagement
  module Generators
    module CalendarManagementHelper
      def model_exists?
        File.exist?(File.join(destination_root, model_path))
      end

      def migration_exists?
        Dir.glob("#{File.join(destination_root, migration_path)}/[0-9]*_*.rb").first
      end

      def migration_path
        @migration_path ||= File.join("db", "migrate")
      end

      def model_path
        @model_path ||= File.join("app", "models", "#{file_path}.rb")
      end
    end
  end
end
