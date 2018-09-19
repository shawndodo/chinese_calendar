# frozen_string_literal: true

module ChineseHoliday::Concerns
  module Models
    module ChineseCalendar
      extend ActiveSupport::Concern

      included do

        scope :weekday, -> { where(special_type: ChineseCalendar::SpecialType::WORK) }

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

          # 公司设置的
          COMPANY_SETTING = [
              COMPANY_HOLIDAY, COMPANY_WORK, COMPANY_REST
          ]

          # 实际休息日
          REST = [
              WEEKEND, CIVIC_HOLIDAY, CIVIC_REST,
              COMPANY_HOLIDAY, COMPANY_REST
          ]

          WORK = [
              WORKDAY, CIVIC_WORK, COMPANY_WORK
          ]

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

        # 获取选定日期内的工作日
        def get_weekday(start_year: Date.today.year, start_month: 1, start_day: 1, end_year: start_year, end_month: 12, end_day: 31)
          self.where(current_date: Date.new(start_year, start_month, start_day)..Date.new(end_year, end_month, end_day)).weekday
        end

      end

    end
  end
end
