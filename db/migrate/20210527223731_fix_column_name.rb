class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :conversation_count, :conversations_count
  end
end
