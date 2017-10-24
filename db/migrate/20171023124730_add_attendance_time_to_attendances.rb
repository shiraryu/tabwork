class AddAttendanceTimeToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :attendance_time, :float
  end
end
