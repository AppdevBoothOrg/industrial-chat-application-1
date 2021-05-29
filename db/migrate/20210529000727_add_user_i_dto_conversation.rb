class AddUserIDtoConversation < ActiveRecord::Migration[6.1]
  def change
    add_column :conversations, :user_id, :integer
  end
end
