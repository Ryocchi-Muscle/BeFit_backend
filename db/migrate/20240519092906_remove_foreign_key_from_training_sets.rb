class RemoveForeignKeyFromTrainingSets < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :training_sets, :training_menus
  end
end
