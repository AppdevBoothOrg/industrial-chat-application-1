# frozen_string_literal: true

# == Schema Information
#
# Table name: conversations
#
#  id                        :bigint           not null, primary key
#  comments_count            :integer          default(0)
#  status                    :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  company_representative_id :bigint           not null
#  customer_id               :bigint           not null
#  user_id                   :integer
#
# Indexes
#
#  index_conversations_on_company_representative_id  (company_representative_id)
#  index_conversations_on_customer_id                (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_representative_id => users.id)
#  fk_rails_...  (customer_id => users.id)
#
class Conversation < ApplicationRecord
  belongs_to :company_representative, class_name: 'User', counter_cache: true
  belongs_to :customer, class_name: 'User', counter_cache: true
  has_many :comments
  belongs_to :user

  enum status: { open: "open", closed: "closed", urgent: "urgent" }
end
