# frozen_string_literal: true

# == Schema Information
#
# Table name: ratings
#
#  id                                                              :bigint           not null, primary key
#  grader_id                                                       :bigint           not null
#  gradee_id                                                       :bigint           not null
#  created_at                                                      :datetime         not null
#  updated_at                                                      :datetime         not null
#  grade                                                           :integer
#  #<ActiveRecord::ConnectionAdapters::PostgreSQL::TableDefinition :integer
#
class Rating < ApplicationRecord
  belongs_to :grader, class_name: 'User', counter_cache: true
  belongs_to :gradee, class_name: 'User', counter_cache: true

  validates :grade, presence: true
  validates_inclusion_of :grade, in: 0..5
end
