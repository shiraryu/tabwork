class AddSumConstructiontimeToWorktimeAggregates < ActiveRecord::Migration
  def change
    add_column :worktime_aggregates, :sum_constructiontime, :float
  end
end
