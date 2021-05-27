# frozen_string_literal: true

class AddStatusToConversations < ActiveRecord::Migration[6.1]
  def change
    add_column :conversations, :status, :string
  end
end
