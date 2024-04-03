class DropTrainingRecord < ActiveRecord::Migration[7.0]
  def change
    drop_table :training_records
  end
end
