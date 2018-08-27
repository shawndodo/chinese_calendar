# frozen_string_literal: true

module ChineseHoliday
  class CalendarInit

    class << self

      def init_calendar(year)

        # 得到指定年份的日期
        date_arr = get_date_range(year)

        # 获取指定日期的信息
        url = HttpBase::URL + date_arr.join(',')
        result = HttpBase.send_request :get, url

        # 根据得到的数据批量创建或修改日期
        parse_batch_result(result)

      end

      def get_date_range(year)
        Date.new(year, 1, 1).upto(Date.new(year, 12, 31)).to_a
      end

      def parse_batch_result(result)
        ChineseCalendar.transaction do
          result['holiday'].each do |k, v|
            date_hash = Date._parse(k)
            date = k.to_date

            date_params = {
                year: date_hash[:year],
                month: date_hash[:month],
                day: date_hash[:day],
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
              calendar_record.update! date_params
            else
              ChineseCalendar.create! date_params
            end
          end
        end
      end

    end

  end
end
