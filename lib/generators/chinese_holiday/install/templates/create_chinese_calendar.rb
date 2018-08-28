class CreateChineseCalendar < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :chinese_calendars, comment: '中国日历' do |t|
      t.datetime :current_date, comment: '当前日期'
      t.string :name_cn, comment: '当前日期中文名称'
      t.integer :year, index: true, comment: '年份'
      t.integer :month, comment: '月份'
      t.integer :day, comment: '日期'
      t.integer :yday, comment: '一年中的第几天'
      t.string :what_day, index: true, comment: '星期几'
      t.string :special_type, index: true, comment: '特殊类型 工作日/法定假日/公司假日/调休日'
      t.string :target, comment: '调休所属节假日名称'
      t.boolean :after, comment: '调休日期所属位置，true是在节假日后，false是在节假日前'

      t.string :remark, comment: '备注'

      t.timestamps null: false
    end
  end
end
