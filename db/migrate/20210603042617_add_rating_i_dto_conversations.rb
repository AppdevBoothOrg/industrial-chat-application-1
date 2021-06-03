class AddRatingIDtoConversations < ActiveRecord::Migration[6.1]
  def change
    add_column :conversations, :rating_id, :integer
    add_column :ratings, :conversation_id, :integer
  end
end
