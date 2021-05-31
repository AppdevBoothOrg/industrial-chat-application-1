# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id              :bigint           not null, primary key
#  body            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  author_id       :bigint           not null
#  conversation_id :integer
#
# Indexes
#
#  index_comments_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: true
  belongs_to :conversation, counter_cache: true, dependent: :destroy
  after_create_commit -> { broadcast_append_to conversation }

  validates :body, presence: true
end
