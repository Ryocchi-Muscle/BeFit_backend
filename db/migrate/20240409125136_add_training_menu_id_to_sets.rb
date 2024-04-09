class AddTrainingMenuIdToSets < ActiveRecord::Migration[7.0]
  def change
    add_reference :sets, :training_menu, null: false, foreign_key: true
  end
end
