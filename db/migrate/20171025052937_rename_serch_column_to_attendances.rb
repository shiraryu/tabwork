class RenameSerchColumnToAttendances < ActiveRecord::Migration
  def change
    rename_column :attendances, :date_serch, :date_search
  end
end
