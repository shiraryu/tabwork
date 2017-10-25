class ChangeDatatypeDateSearchOfAttendances < ActiveRecord::Migration
  def change
    change_column :attendances, :date_search, :date
  end
end
