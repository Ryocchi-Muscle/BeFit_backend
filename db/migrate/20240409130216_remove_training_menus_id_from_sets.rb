class RemoveTrainingMenusIdFromSets < ActiveRecord::Migration[7.0]
  def change
    remove_column :sets, :training_menus_id, :bigint
  end
end
