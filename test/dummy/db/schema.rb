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

ActiveRecord::Schema.define(version: 20180212111604) do

  create_table "slider_carrousels", force: :cascade do |t|
    t.text "carrouselName", limit: 65535
    t.text "type_slide",    limit: 65535
    t.text "img_class",     limit: 65535
  end

  create_table "slider_galleries", force: :cascade do |t|
    t.integer  "carrousel_id", limit: 4
    t.text     "galleryName",  limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slider_galleries", ["carrousel_id"], name: "index_slider_galleries_on_carrousel_id", using: :btree

  create_table "slider_orders", force: :cascade do |t|
    t.integer "upload_id",  limit: 4
    t.integer "gallery_id", limit: 4
    t.integer "order",      limit: 4
  end

  add_index "slider_orders", ["gallery_id"], name: "index_slider_orders_on_gallery_id", using: :btree
  add_index "slider_orders", ["upload_id"], name: "index_slider_orders_on_upload_id", using: :btree

  create_table "slider_uploads", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_foreign_key "slider_galleries", "slider_carrousels", column: "carrousel_id"
  add_foreign_key "slider_orders", "slider_galleries", column: "gallery_id"
  add_foreign_key "slider_orders", "slider_uploads", column: "upload_id"
end
