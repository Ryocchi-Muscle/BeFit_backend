class RenameSetsToTrainingSets < ActiveRecord::Migration[7.0]
  def change
    rename_table :sets, :training_sets
  end
end
