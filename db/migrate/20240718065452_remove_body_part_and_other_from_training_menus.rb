class RemoveBodyPartAndOtherFromTrainingMenus < ActiveRecord::Migration[7.0]
  def change
    remove_column :training_menus, :body_part, :string
    remove_column :training_menus, :other, :string
  end
end
