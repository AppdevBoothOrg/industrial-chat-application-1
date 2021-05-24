class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.references :company_representative, null: false, foreign_key: { to_table: :users }, index: true
      t.references :customer, null: false, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end
  end
end
