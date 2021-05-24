# frozen_string_literal: true

# == Schema Information
#
# Table name: conversations
#
#  id                        :bigint           not null, primary key
#  company_representative_id :bigint           not null
#  customer_id               :bigint           not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
class Conversation < ApplicationRecord
  belongs_to :company_representative, class_name: 'User'
  belongs_to :customer, class_name: 'User'
  has_many :comments
end
