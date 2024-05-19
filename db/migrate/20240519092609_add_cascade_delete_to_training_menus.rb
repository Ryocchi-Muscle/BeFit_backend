class AddCascadeDeleteToTrainingMenus < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :training_menus, :training_days, on_delete: :cascade
  end
end
