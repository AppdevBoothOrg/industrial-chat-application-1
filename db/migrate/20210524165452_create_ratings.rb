# frozen_string_literal: true

class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.references :grader, null: false, foreign_key: { to_table: :users }, index: true
      t.references :gradee, null: false, foreign_key: { to_table: :users }, index: true
      t.integer :grade,
                t.timestamps
    end
  end
end
