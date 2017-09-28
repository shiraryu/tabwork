class AddWorkplaceIdToConstructions < ActiveRecord::Migration
  def change
    add_column :constructions, :workplace_id, :integer
  end
end
