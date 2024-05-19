class RemoveExistingForeignKeyFromTrainingDays < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :training_days, name: "fk_rails_a5d156f0f9"
  end
end
