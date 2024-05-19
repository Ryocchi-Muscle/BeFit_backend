class AddCascadeDeleteToTrainingSets < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :training_sets, :training_menus, on_delete: :cascade
  end
end
