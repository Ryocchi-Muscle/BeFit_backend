class AddWeekPrograms < ActiveRecord::Migration[7.0]
  def change
    add_column :programs, :week, :integer
  end
end
