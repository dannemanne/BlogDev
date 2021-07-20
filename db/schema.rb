# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_20_054301) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "cheat_sheets", id: :serial, force: :cascade do |t|
    t.string "category"
    t.string "title"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "image_content_type"
    t.string "image_file_size"
    t.string "image_file_name"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_images_on_user_id"
  end

  create_table "linkbacks", id: :serial, force: :cascade do |t|
    t.string "source_uri"
    t.string "target_uri"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_images", id: :serial, force: :cascade do |t|
    t.integer "post_id"
    t.integer "image_id"
    t.index ["image_id"], name: "index_post_images_on_image_id"
    t.index ["post_id"], name: "index_post_images_on_post_id"
  end

  create_table "post_tags", id: :serial, force: :cascade do |t|
    t.integer "post_id"
    t.integer "tag_id"
    t.index ["post_id"], name: "index_post_tags_on_post_id"
    t.index ["tag_id", "post_id"], name: "index_post_tags_on_tag_id_and_post_id", unique: true
    t.index ["tag_id"], name: "index_post_tags_on_tag_id"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title"
    t.text "body"
    t.integer "status", default: 0, null: false
    t.datetime "posted_at"
    t.integer "comments_count", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "title_url"
    t.boolean "allow_comments", default: false, null: false
    t.text "parsed_body"
    t.text "parsed_preview"
    t.string "meta_description"
    t.index ["posted_at"], name: "index_posts_on_posted_at"
    t.index ["status"], name: "index_posts_on_status"
    t.index ["title_url"], name: "index_posts_on_title_url", unique: true
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "posts_count", default: 0, null: false
    t.string "stub", null: false
    t.index ["posts_count"], name: "index_tags_on_posts_count"
    t.index ["stub"], name: "index_tags_on_stub"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.integer "role", default: 0, null: false
    t.boolean "use_gravatar", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
