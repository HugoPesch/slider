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

ActiveRecord::Schema.define(version: 20180129101547) do

  create_table "images", force: :cascade do |t|
    t.text     "url",              limit: 65535
    t.integer  "images_slider_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["images_slider_id"], name: "index_images_on_images_slider_id", using: :btree

  create_table "images_sliders", force: :cascade do |t|
    t.integer  "slider_id",  limit: 4
    t.integer  "numIS",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images_sliders", ["slider_id"], name: "index_images_sliders_on_slider_id", using: :btree

  create_table "sliders", force: :cascade do |t|
    t.text     "name",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "images", "images_sliders"
  add_foreign_key "images_sliders", "sliders"
end
