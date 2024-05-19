class RemoveForeignKeyFromTrainingMenus < ActiveRecord::Migration[7.0]
  def change
       remove_foreign_key :training_menus, :training_days
  end
end
