class CreateSets < ActiveRecord::Migration[7.0]
  def change
    create_table :sets do |t|
      t.references :exercise, null: false, foreign_key: true
      t.integer :set_number
      t.integer :weight
      t.integer :reps
      t.boolean :completed

      t.timestamps
    end
  end
end
