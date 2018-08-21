# frozen_string_literal: true

require 'rails/generators/base'
require 'rails/generators/active_record'

module ChineseHoliday
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include ActiveRecord::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)

      def copy_migrations

        migration_template "create_chinese_calendar.rb", "db/migrate/create_chinese_calendar.rb", migration_version: migration_version

      end

      def generate_model
        copy_file "chinese_calendar.rb", "app/models/chinese_calendar.rb"
      end


      private

      def migration_version
        major = ActiveRecord::VERSION::MAJOR
        if major >= 5
          "[#{major}.#{ActiveRecord::VERSION::MINOR}]"
        end
      end

    end
  end
end
