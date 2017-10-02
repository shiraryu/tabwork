class AddClosingTimeToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :closing_time, :time
  end
end
