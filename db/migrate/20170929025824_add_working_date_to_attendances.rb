class AddWorkingDateToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :working_date, :date
  end
end
