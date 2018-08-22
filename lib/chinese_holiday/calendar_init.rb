module ChineseHoliday
  class CalendarInit

    class << self

      def init_calendar(year)
        ChineseCalendar.transaction do
          Date.new(year, 1, 1).upto(Date.new(year, 12, 31)) do |date|
            calendar_params = {
                year: date.year,
                month: date.month,
                day: date.day,
                what_day: ChineseCalendar.convert_day(date)
            }
            ChineseCalendar.create! calendar_params
          end
        end

      end

    end

  end
end
