class AddCommentIDtoConversations < ActiveRecord::Migration[6.1]
  def change
    add_column :conversations, :comment_id, :integer
  end
end
