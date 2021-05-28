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
  has_many :conversations
  has_many :company_conversations, foreign_key: :company_representative_id, class_name: 'Conversation'
  has_many :customer_conversations, foreign_key: :customer_id, class_name: 'Conversation'
  has_many :grader_ratings, foreign_key: :grader_id, class_name: 'Rating'
  has_many :gradee_ratings, foreign_key: :gradee_id, class_name: 'Rating'
end
