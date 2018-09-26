# frozen_string_literal: true

module ChineseHoliday
  module ChineseCalendarSupport
    extend ActiveSupport::Concern

    module ClassMethods
      def validate_date(start_date, end_date)
        raise StandardError, "没有起止日期" if start_date.blank? || end_date.blank?
        begin
          # 初始化日期
          start_date = start_date.to_date
          end_date = end_date.to_date
        rescue ArgumentError
          raise ArgumentError, "输入的日期参数格式错误"
        end
        raise StandardError, "输入的初始日期大于截止日期" if start_date > end_date
        return start_date, end_date
      end
    end

  end
end
