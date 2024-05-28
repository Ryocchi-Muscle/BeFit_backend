class AddSetInfoAndOtherToTrainingMenus < ActiveRecord::Migration[7.0]
  def change
    add_column :training_menus, :set_info, :string
    add_column :training_menus, :other, :string
  end
end
