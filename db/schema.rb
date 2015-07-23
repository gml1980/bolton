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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150723121941) do

  create_table "file_attachments", force: true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.text     "description"
    t.integer  "forum_post_id"
    t.integer  "forum_reply_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_categories", force: true do |t|
    t.text     "name",                      null: false
    t.string   "description",               null: false
    t.integer  "position",    default: 100, null: false
    t.integer  "status",      default: 0,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_posts", force: true do |t|
    t.text     "subject",                     null: false
    t.string   "post_body",                   null: false
    t.integer  "forum_id"
    t.boolean  "sticky",      default: false
    t.boolean  "locked",      default: false
    t.boolean  "email_users", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "forum_posts", ["forum_id"], name: "index_forum_posts_on_forum_id"
  add_index "forum_posts", ["user_id"], name: "index_forum_posts_on_user_id"

  create_table "forum_replies", force: true do |t|
    t.string   "post_body",                        null: false
    t.integer  "forum_post_id",                    null: false
    t.integer  "forum_replies_id"
    t.boolean  "email_users",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "forum_replies", ["forum_post_id"], name: "index_forum_replies_on_forum_post_id"
  add_index "forum_replies", ["forum_replies_id"], name: "index_forum_replies_on_forum_replies_id"
  add_index "forum_replies", ["user_id"], name: "index_forum_replies_on_user_id"

  create_table "forums", force: true do |t|
    t.text     "name",                            null: false
    t.string   "description",                     null: false
    t.integer  "position",          default: 100, null: false
    t.integer  "forum_category_id"
    t.integer  "status",            default: 0,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forums", ["forum_category_id"], name: "index_forums_on_forum_category_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "user_role",              default: 2
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
