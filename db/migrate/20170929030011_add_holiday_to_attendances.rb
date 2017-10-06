class AddHolidayToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :holiday, :boolean
  end
end
