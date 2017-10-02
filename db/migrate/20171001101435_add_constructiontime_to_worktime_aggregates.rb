class AddConstructiontimeToWorktimeAggregates < ActiveRecord::Migration
  def change
    add_column :worktime_aggregates, :constructiontime, :integer
  end
end
