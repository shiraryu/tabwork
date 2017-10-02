class AddOverTimeToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :over_time, :float
  end
end
