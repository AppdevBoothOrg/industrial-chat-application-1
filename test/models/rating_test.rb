# frozen_string_literal: true

# == Schema Information
#
# Table name: ratings
#
#  id                                                              :bigint           not null, primary key
#  #<ActiveRecord::ConnectionAdapters::PostgreSQL::TableDefinition :integer
#  grade                                                           :integer
#  created_at                                                      :datetime         not null
#  updated_at                                                      :datetime         not null
#  conversation_id                                                 :integer
#  gradee_id                                                       :bigint           not null
#  grader_id                                                       :bigint           not null
#
# Indexes
#
#  index_ratings_on_gradee_id  (gradee_id)
#  index_ratings_on_grader_id  (grader_id)
#
# Foreign Keys
#
#  fk_rails_...  (gradee_id => users.id)
#  fk_rails_...  (grader_id => users.id)
#
require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
