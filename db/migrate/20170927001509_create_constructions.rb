class CreateConstructions < ActiveRecord::Migration
  def change
    create_table :constructions do |t|
      t.text :name

      t.timestamps null: false
    end
  end
end
