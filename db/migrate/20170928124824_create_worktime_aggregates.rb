class CreateWorktimeAggregates < ActiveRecord::Migration
  def change
    create_table :worktime_aggregates do |t|
      t.integer :construction_id
      t.integer :attendance_id

      t.timestamps null: false
    end
  end
end
