class ChangeColumnToAttendance < ActiveRecord::Migration
  # 変更内容
  def up
    change_column :attendances, :holiday, :boolean, default: false, null: false
  end

  # 変更前の状態
  def down
    change_column :attendances, :holiday, :string
  end
end
