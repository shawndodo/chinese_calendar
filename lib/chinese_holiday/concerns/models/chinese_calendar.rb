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

          WEEKEND = [SATURDAY, SUNDAY]

          # 选项
          OPTIONS = get_all_options

          # 全部
          ALL = get_all_values
        end

        module SpecialType
          include Dictionary::Module::I18n

          # 工作日
          WORKDAY = 'workday'

          # 周末
          WEEKEND = 'weekend'

          # 法定假日
          CIVIC_HOLIDAY = 'civic_holiday'

          # 法定调休工作
          CIVIC_WORK = 'civic_work'

          # 法定调休休息
          CIVIC_REST = 'civic_rest'

          # 公司假日
          COMPANY_HOLIDAY = 'company_holiday'

          # 公司调休工作
          COMPANY_WORK = 'company_work'

          # 公司调休修改
          COMPANY_REST = 'company_rest'

          # 选项
          OPTIONS = get_all_options

          # 全部
          ALL = get_all_values
        end

      end

      module ClassMethods

        def convert_day_to_what_day(date)
          case date.to_date.cwday
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

        def get_common_day_special_type(date)
          [6, 7].include?(date.to_date.cwday) ? ChineseCalendar::SpecialType::WEEKEND : ChineseCalendar::SpecialType::WORKDAY
        end

      end

    end
  end
end
