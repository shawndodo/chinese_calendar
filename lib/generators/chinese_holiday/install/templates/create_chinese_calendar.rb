class CreateChineseCalendar < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :chinese_calendars, comment: '中国日历' do |t|
      t.datetime :current_date, comment: '当前日期'
      t.string :name, comment: '当前日期中文名称'
      t.string :year, comment: '年份'
      t.string :month, comment: '月份'
      t.string :day, comment: '日期'
      t.string :what_day, index: true, comment: '星期几'
      t.string :special_type, index: true, comment: '特殊类型 工作日/法定假日/公司假日'
      t.string :remark, comment: '备注'

      t.timestamps null: false
    end
  end
end
