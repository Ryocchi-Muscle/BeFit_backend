class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises do |t|
      t.references :training_day, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
