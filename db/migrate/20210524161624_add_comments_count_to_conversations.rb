# frozen_string_literal: true

class AddCommentsCountToConversations < ActiveRecord::Migration[6.1]
  def change
    add_column :conversations, :comments_count, :integer, default: 0
  end
end
