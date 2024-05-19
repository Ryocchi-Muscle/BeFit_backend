class AddCascadeDeleteToTrainingDays < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :training_days, :users, on_delete: :cascade
  end
end
