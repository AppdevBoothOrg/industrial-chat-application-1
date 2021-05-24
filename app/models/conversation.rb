class Conversation < ApplicationRecord
  belongs_to :company_representative, class_name: "User"
  belongs_to :customer, class_name: "User"
end
