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

ActiveRecord::Schema.define(version: 20140808185309) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feeds", force: true do |t|
    t.string   "uuid"
    t.string   "name"
    t.text     "url"
    t.datetime "last_fetched"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  add_index "feeds", ["created_at"], name: "index_feeds_on_created_at", using: :btree
  add_index "feeds", ["slug"], name: "index_feeds_on_slug", using: :btree
  add_index "feeds", ["url"], name: "index_feeds_on_url", using: :btree
  add_index "feeds", ["uuid"], name: "index_feeds_on_uuid", using: :btree

  create_table "stories", force: true do |t|
    t.string   "uuid"
    t.integer  "feed_id"
    t.text     "title"
    t.text     "permalink"
    t.text     "body"
    t.datetime "published"
    t.boolean  "is_read"
    t.boolean  "starred"
    t.boolean  "keep_unread"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "entry_id"
  end

  add_index "stories", ["feed_id"], name: "index_stories_on_feed_id", using: :btree
  add_index "stories", ["published"], name: "index_stories_on_published", using: :btree
  add_index "stories", ["slug"], name: "index_stories_on_slug", using: :btree
  add_index "stories", ["starred"], name: "index_stories_on_starred", using: :btree
  add_index "stories", ["uuid"], name: "index_stories_on_uuid", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
