# frozen_string_literal: true

require "chinese_holiday/chinese_calendar_support"

module ChineseHoliday::Concerns
  module Models
    module ChineseCalendar
      extend ActiveSupport::Concern

      included do

        include ChineseHoliday::ChineseCalendarSupport

        scope :weekday, -> { where(special_type: ChineseCalendar::SpecialType::WORK) }

        scope :rest_day, -> { where(special_type: ChineseCalendar::SpecialType::REST) }

        module WhatDay
          include ChineseHoliday::Dictionary::Module::I18n

          MONDAY = "monday"

          TUESDAY = "tuesday"

          WEDNESDAY = "wednesday"

          THURSDAY = "thursday"

          FRIDAY = "friday"

          SATURDAY = "saturday"

          SUNDAY = "sunday"

          WEEKEND = [SATURDAY, SUNDAY]

          # 选项
          OPTIONS = get_all_options

          # 全部
          ALL = get_all_values
        end

        module SpecialType
          include ChineseHoliday::Dictionary::Module::I18n

          # 工作日
          WORKDAY = "workday"

          # 周末
          WEEKEND = "weekend"

          # 法定假日
          CIVIC_HOLIDAY = "civic_holiday"

          # 法定调休工作
          CIVIC_WORK = "civic_work"

          # 法定调休休息
          CIVIC_REST = "civic_rest"

          # 公司假日
          COMPANY_HOLIDAY = "company_holiday"

          # 公司调休工作
          COMPANY_WORK = "company_work"

          # 公司调休修改
          COMPANY_REST = "company_rest"

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

        # 得到指定日期是星期几
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

        # 判断到底是工作日还是休息日
        # ChineseCalendar.get_common_day_special_type('2018-01-01'.to_date)
        def get_common_day_special_type(date)
          [6, 7].include?(date.to_date.cwday) ? ChineseCalendar::SpecialType::WEEKEND : ChineseCalendar::SpecialType::WORKDAY
        end

        # 获得休息日或工作日
        # ChineseCalendar.get_weekday
        # ChineseCalendar.get_rest_day
        %w(weekday rest_day).each do |k|
          define_method "get_#{k}" do |start_date: Date.today.beginning_of_year, end_date: Date.today.end_of_year|
            start_date, end_date = validate_date(start_date, end_date)
            self.where(current_date: start_date..end_date).public_send(k)
          end
        end

      end

    end
  end
end
