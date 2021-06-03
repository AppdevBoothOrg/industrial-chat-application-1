# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  comments_count         :integer          default(0)
#  conversations_count    :integer          default(0)
#  customer               :boolean          default(TRUE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  rating                 :integer          default(5)
#  ratings_count          :integer
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :citext
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true
  validates :username, length: { in: 3..20 }
  validates_format_of :username, with: /\A[A-Za-z]*\z/

  validates :email, uniqueness: true

  has_many :comments, foreign_key: :author_id
  has_many :company_conversations, foreign_key: :company_representative_id, class_name: 'Conversation'
  has_many :customer_conversations, foreign_key: :customer_id, class_name: 'Conversation'
  has_many :grader_ratings, foreign_key: :grader_id, class_name: 'Rating'
  has_many :gradee_ratings, foreign_key: :gradee_id, class_name: 'Rating'

  def calculate_average_rating
    sum = 0
    self.grader_ratings.each do |a_grade|
      sum = sum + a_grade.grade
    end
    1.0 * sum / (0.5*self.ratings_count)
  end

  def self.weave_username_and_id_into_array
    array_of_usernames = User.where( { customer: true } ).pluck(:username)
    array_of_ids = User.where( { customer: true } ).pluck(:id)
    
    the_weaved_array = []
    the_length = array_of_usernames.length
    
    the_length.times do |the_index|
      the_weaved_array.append( [array_of_usernames[the_index] , array_of_ids[the_index] ] )
    end

    return the_weaved_array
  end

end
