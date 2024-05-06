class UpdateIndexOnTrainingDays < ActiveRecord::Migration[7.0]
  def change
    remove_index :training_days, name: "index_training_days_on_date", if_exists: true
    add_index :training_days, [:user_id, :date], unique: true, name: 'index_training_days_on_user_id_and_date'
  end
end
