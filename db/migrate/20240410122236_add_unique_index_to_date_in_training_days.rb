class AddUniqueIndexToDateInTrainingDays < ActiveRecord::Migration[7.0]
  def change
    add_index :training_days, :date, unique: true
  end
end
