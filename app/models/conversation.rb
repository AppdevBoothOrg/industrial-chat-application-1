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
#  comments_count            :integer          default(0)
#  status                    :string
#
class Conversation < ApplicationRecord
  belongs_to :company_representative, class_name: 'User', counter_cache: true
  belongs_to :customer, class_name: 'User', counter_cache: true
  has_many :comments
  
  enum status: { open: "open", closed: "closed", urgent: "urgent" }
end
