class Dlete < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :sets, :exercises
    drop_table :exercises
  end
end
