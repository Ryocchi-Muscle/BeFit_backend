class DropTrainingSessionTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :training_sessions
  end
end
