# frozen_string_literal: true

module ChineseHoliday::Concerns
  module Models
    module ChineseCalendar
      extend ActiveSupport::Concern

      included do

        module WhatDay
          include Dictionary::Module::I18n

          MONDAY = 'monday'

          TUESDAY = 'tuesday'

          WEDNESDAY = 'wednesday'

          THURSDAY = 'thursday'

          FRIDAY = 'friday'

          SATURDAY = 'saturday'

          SUNDAY = 'sunday'

          # 选项
          OPTIONS = get_all_options

          # 全部
          ALL = get_all_values
        end

        module SpecialType
          include Dictionary::Module::I18n

          # 工作日
          WORKDAY = 'workday'

          # 法定假日
          CIVIC_HOLIDAY = 'civic_holiday'

          # 法定调休
          CIVIC_REST = 'civic_rest'

          # 公司假日
          COMPANY_HOLIDAY = 'company_holiday'

          # 公司调休
          COMPANY_REST = 'company_rest'

          # 选项
          OPTIONS = get_all_options

          # 全部
          ALL = get_all_values
        end

      end

      module ClassMethods
        def convert_day(date)
          case date.cwday
          when 1
            ChineseCalendar::WhatDay::MONDAY
          when 2
            ChineseCalendar::WhatDay::TUESDAY
          when 3
            ChineseCalendar::WhatDay::WEDNESDAY
          when 4
            ChineseCalendar::WhatDay::THURSDAY
          when 5
            ChineseCalendar::WhatDay::FRIDAY
          when 6
            ChineseCalendar::WhatDay::SATURDAY
          when 7
            ChineseCalendar::WhatDay::SUNDAY
          end
        end
      end

    end
  end
end
