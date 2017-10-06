class AddColumnToAttendance < ActiveRecord::Migration
  def change
    add_column :attendances, :opening_datetime, :datetime
    add_column :attendances, :closing_datetime, :datetime
    remove_column :attendances, :opening_time, :time
    remove_column :attendances, :closing_time, :time
    remove_column :attendances, :working_date, :date
  end
end
