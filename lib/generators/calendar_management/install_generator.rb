module CalendarManagement
  class InstallGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("../templates", __FILE__)

    def copy_migrations

      if (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?)
        migration_template "migration_existing.rb", "db/migrate/add_calendar_params_to_#{table_name}.rb", migration_version: migration_version
      else
        migration_template "migration.rb", "db/migrate/create_#{table_name}.rb", migration_version: migration_version
      end
    end

    def create_calendar_model
      invoke "active_record:model", [file_name], migration: false unless model_exists? && behavior == :invoke
    end


    def create_calendar_controllers
      create_file "app/controllers/#{file_name.pluralize}_controller.rb", <<-FILE
class #{file_name.pluralize.humanize}Controller < AtyunUser::AtyunUsersController

end
      FILE
    end

    def migration_data
      <<RUBY
      t.datetime :current_date, comment: '当前日期'
      t.string :year, comment: '年份'
      t.string :month, comment: '月份'
      t.string :day, comment: '日期'
      t.string :what_day, comment: '星期几'
      t.string :special_type, comment: '特殊类型 法定假日/公司假日'
      t.string :remark, comment: '备注'

      

RUBY
    end


    def inet?
      postgresql?
    end

    def postgresql?
      config = ActiveRecord::Base.configurations[Rails.env]
      config && config['adapter'] == 'postgresql'
    end

    def migration_version
      major = ActiveRecord::VERSION::MAJOR
      if major >= 5
        "[#{major}.#{ActiveRecord::VERSION::MINOR}]"
      end
    end

  end
end