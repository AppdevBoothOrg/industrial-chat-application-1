# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  username               :citext
#  customer               :boolean          default(TRUE)
#  rating                 :integer          default(5)
#  comments_count         :integer          default(0)
#  conversation_count     :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
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
  has_many :company_conversations, foreign_key: :company_representative_id, class_name: 'Conversations'
  has_many :customer_conversations, foreign_key: :customer_id, class_name: 'Conversations'
  has_many :grader_ratings, foreign_key: :grader_id, class_name: 'Ratings'
  has_many :gradee_ratings, foreign_key: :gradee_id, class_name: 'Ratings'
end
