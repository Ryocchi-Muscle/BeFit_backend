class CreateTrainingSets < ActiveRecord::Migration[7.0]
  def change
    create_table :training_sets do |t|
      t.integer :weight
      t.integer :reps
      t.boolean :completed

      t.timestamps
    end
  end
end
