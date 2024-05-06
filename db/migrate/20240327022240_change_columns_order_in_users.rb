class ChangeColumnsOrderInUsers < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      ALTER TABLE users MODIFY COLUMN uid VARCHAR(255) FIRST;
    SQL
    execute <<-SQL
      ALTER TABLE users MODIFY COLUMN name VARCHAR(255) AFTER uid;
    SQL
    execute <<-SQL
      ALTER TABLE users MODIFY COLUMN provider VARCHAR(255) AFTER name;
    SQL
    # created_at と updated_at は既に望む順序にあるため、変更不要
  end
end
