class AddDateSerchToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :date_serch, :datetime
  end
end
