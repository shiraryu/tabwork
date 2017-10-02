class AddOpeningTimeToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :opening_time, :time
  end
end
