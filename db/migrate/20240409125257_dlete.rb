class Dlete < ActiveRecord::Migration[7.0]
  def change
    drop_table :exercises
  end
end
