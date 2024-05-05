class DropTrainingRecords < ActiveRecord::Migration[7.0]
  def change
    drop_table :training_records, if_exists: true
  end
end
