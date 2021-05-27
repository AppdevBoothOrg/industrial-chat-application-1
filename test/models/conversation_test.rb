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
require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
