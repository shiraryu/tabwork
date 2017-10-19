class AddBreakTimeToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :break_time, :float
  end
end
