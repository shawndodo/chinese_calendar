# frozen_string_literal: true

module ChineseCalendar
  module Generators
    class ModelGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def generate_model
        copy_file "chinese_calendar.rb", "app/models/chinese_calendar.rb"
      end
    end
  end
end
