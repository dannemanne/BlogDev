# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120905062510) do

  create_table "cheat_sheets", :force => true do |t|
    t.string   "category"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id",     :null => false
    t.string   "title"
    t.string   "message_old"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.string   "name"
    t.string   "website"
    t.text     "message"
  end

  add_index "comments", ["ancestry"], :name => "index_comments_on_ancestry"

  create_table "images", :force => true do |t|
    t.integer  "user_id"
    t.string   "image_content_type"
    t.string   "image_file_size"
    t.string   "image_file_name"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "images", ["user_id"], :name => "index_images_on_user_id"

  create_table "linkbacks", :force => true do |t|
    t.string   "source_uri"
    t.string   "target_uri"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "post_images", :force => true do |t|
    t.integer "post_id"
    t.integer "image_id"
  end

  add_index "post_images", ["image_id"], :name => "index_post_images_on_image_id"
  add_index "post_images", ["post_id"], :name => "index_post_images_on_post_id"

  create_table "post_tags", :force => true do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  add_index "post_tags", ["post_id"], :name => "index_post_tags_on_post_id"
  add_index "post_tags", ["tag_id", "post_id"], :name => "index_post_tags_on_tag_id_and_post_id", :unique => true
  add_index "post_tags", ["tag_id"], :name => "index_post_tags_on_tag_id"

  create_table "posts", :force => true do |t|
    t.integer  "user_id",                             :null => false
    t.string   "title"
    t.text     "body"
    t.integer  "status",           :default => 0,     :null => false
    t.datetime "posted_at"
    t.integer  "comments_count",   :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title_url"
    t.boolean  "allow_comments",   :default => false, :null => false
    t.text     "parsed_body"
    t.text     "parsed_preview"
    t.string   "meta_description"
  end

  add_index "posts", ["posted_at"], :name => "index_posts_on_posted_at"
  add_index "posts", ["status"], :name => "index_posts_on_status"
  add_index "posts", ["title_url"], :name => "index_posts_on_title_url", :unique => true
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "posts_count", :default => 0, :null => false
    t.string  "stub",                       :null => false
  end

  add_index "tags", ["posts_count"], :name => "index_tags_on_posts_count"
  add_index "tags", ["stub"], :name => "index_tags_on_stub"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "role"
    t.boolean  "use_gravatar",                        :default => false, :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role"], :name => "index_users_on_role"

end
