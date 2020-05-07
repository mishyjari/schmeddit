# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_07_021502) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "parent_id"
    t.string "parent_type"
    t.integer "score", default: 0
    t.index ["parent_type", "parent_id"], name: "index_comments_on_parent_type_and_parent_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "user_id", null: false
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "score", default: 0
    t.integer "num_favorites", default: 0
    t.index ["category_id"], name: "index_posts_on_category_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "user_comment_votes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "comment_id", null: false
    t.boolean "up_vote?"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["comment_id"], name: "index_user_comment_votes_on_comment_id"
    t.index ["user_id"], name: "index_user_comment_votes_on_user_id"
  end

  create_table "user_favorite_categories", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_user_favorite_categories_on_category_id"
    t.index ["user_id"], name: "index_user_favorite_categories_on_user_id"
  end

  create_table "user_favorite_posts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_user_favorite_posts_on_post_id"
    t.index ["user_id"], name: "index_user_favorite_posts_on_user_id"
  end

  create_table "user_post_votes", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "user_id", null: false
    t.boolean "up_vote?"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_user_post_votes_on_post_id"
    t.index ["user_id"], name: "index_user_post_votes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "profile_img_url"
    t.text "bio"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "comments", "users"
  add_foreign_key "posts", "categories"
  add_foreign_key "posts", "users"
  add_foreign_key "user_comment_votes", "comments"
  add_foreign_key "user_comment_votes", "users"
  add_foreign_key "user_favorite_categories", "categories"
  add_foreign_key "user_favorite_categories", "users"
  add_foreign_key "user_favorite_posts", "posts"
  add_foreign_key "user_favorite_posts", "users"
  add_foreign_key "user_post_votes", "posts"
  add_foreign_key "user_post_votes", "users"
end
