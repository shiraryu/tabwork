class ChangeConstructiontimeToWorktimeAggregates < ActiveRecord::Migration
  def up
    change_column :worktime_aggregates, :constructiontime, :float
  end

  # 変更前の状態
  def down
    change_column :worktime_aggregates, :constructiontime, :integer
  end
end
