# frozen_string_literal: true

require "chinese_holiday/chinese_calendar_support"

module ChineseHoliday
  class CalendarInit

    include ChineseCalendarSupport

    class << self

      # 初始化日历数据
      def init_calendar(*args)

        # 得到指定年份的日期
        date_arr = get_date_range(*args)
        # 合成url,发送批量查询请求
        result = send_request_with_url(date_arr)

        # 根据得到的数据批量创建或修改日期
        parse_batch_result(result)

      end

      # 获取需要查询的时间跨度
      def get_date_range(start_date: Date.today.beginning_of_year, end_date: Date.today.end_of_year)
        start_date, end_date = validate_date(start_date, end_date)
        # 初始化日期段
        start_date.upto(end_date).to_a
      end

      # 获取指定日期的信息
      def send_request_with_url(date_arr, url = HttpBase::BATCH_URL, method = :get)
        HttpBase.send_request method, (url + date_arr.join(','))
      end

      # 分析批量查询得到的结果
      def parse_batch_result(result)
        ChineseCalendar.transaction do
          result['holiday'].each do |k, v|
            date_hash = Date._parse(k)
            date = k.to_date

            date_params = {
                year: date_hash[:year],
                month: date_hash[:mon],
                day: date_hash[:mday],
                yday: date.yday,
                what_day: ChineseHoliday::ChineseCalendar.convert_day_to_what_day(date),
                current_date: date,
                special_type: ChineseHoliday::ChineseCalendar.get_common_day_special_type(date)
            }

            date_params.merge!(
                name_cn: v['name'],
                # todo这里还需要看一下因为放假而调整的调休休息的情况
                special_type: v['holiday'] ? ChineseCalendar::SpecialType::CIVIC_HOLIDAY : ChineseCalendar::SpecialType::CIVIC_WORK,
                target: v['target'],
                after: v['after'],
            ) if v.present?

            if (calendar_record = ChineseCalendar.where(current_date: date).first).present?
              date_params.except!(:special_type) if ChineseCalendar::SpecialType::COMPANY_SETTING.include?(calendar_record.special_type)
              calendar_record.update! date_params
            else
              ChineseCalendar.create! date_params
            end
          end
          nil
        end
      end

    end

  end
end
