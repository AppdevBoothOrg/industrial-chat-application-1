# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_03_042617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "conversation_id"
    t.index ["author_id"], name: "index_comments_on_author_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "company_representative_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "comments_count", default: 0
    t.string "status"
    t.integer "comment_id"
    t.integer "rating_id"
    t.index ["company_representative_id"], name: "index_conversations_on_company_representative_id"
    t.index ["customer_id"], name: "index_conversations_on_customer_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "grader_id", null: false
    t.bigint "gradee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "grade"
    t.integer "#<ActiveRecord::ConnectionAdapters::PostgreSQL::TableDefinition"
    t.integer "conversation_id"
    t.index ["gradee_id"], name: "index_ratings_on_gradee_id"
    t.index ["grader_id"], name: "index_ratings_on_grader_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.citext "username"
    t.boolean "customer", default: true
    t.integer "rating", default: 5
    t.integer "comments_count", default: 0
    t.integer "conversations_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "ratings_count"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "conversations", "users", column: "company_representative_id"
  add_foreign_key "conversations", "users", column: "customer_id"
  add_foreign_key "ratings", "users", column: "gradee_id"
  add_foreign_key "ratings", "users", column: "grader_id"
end
