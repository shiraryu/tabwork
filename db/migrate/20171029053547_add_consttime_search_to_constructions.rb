class AddConsttimeSearchToConstructions < ActiveRecord::Migration
  def change
    add_column :constructions, :consttime_search, :date
  end
end
