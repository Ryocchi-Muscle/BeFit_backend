class AddBodyPartToExercise < ActiveRecord::Migration[7.0]
  def change
    add_column :exercises, :body_part, :string
  end
end
