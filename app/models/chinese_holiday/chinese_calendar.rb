# frozen_string_literal: true

module ChineseHoliday
  class ChineseCalendar < ApplicationRecord
    include ChineseHoliday::Concerns::Models::ChineseCalendar

    self.table_name = "chinese_calendars"
  end
end
