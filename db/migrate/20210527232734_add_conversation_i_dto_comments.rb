class AddConversationIDtoComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :conversation_id, :integer
  end
end
