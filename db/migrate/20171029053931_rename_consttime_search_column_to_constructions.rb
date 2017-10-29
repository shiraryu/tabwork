class RenameConsttimeSearchColumnToConstructions < ActiveRecord::Migration
  def change
    rename_column :constructions, :consttime_search, :constdate_search
  end
end
