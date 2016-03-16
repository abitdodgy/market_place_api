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

ActiveRecord::Schema.define(version: 20160206163446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.integer  "total_in_cents",             null: false
    t.integer  "status",         default: 1, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "orders", ["status"], name: "index_orders_on_status", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "placements", force: :cascade do |t|
    t.integer  "order_id",   null: false
    t.integer  "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "placements", ["order_id"], name: "index_placements_on_order_id", using: :btree
  add_index "placements", ["product_id"], name: "index_placements_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "user_id",                        null: false
    t.string   "title",                          null: false
    t.integer  "price_in_cents", default: 0,     null: false
    t.boolean  "published",      default: false, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                  null: false
    t.string   "email",                 null: false
    t.string   "password_digest",       null: false
    t.string   "password_reset_digest"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "auth_token"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["password_reset_digest"], name: "index_users_on_password_reset_digest", unique: true, using: :btree

  add_foreign_key "orders", "users", on_delete: :cascade
  add_foreign_key "placements", "orders", on_delete: :cascade
  add_foreign_key "placements", "products", on_delete: :cascade
  add_foreign_key "products", "users", on_delete: :cascade
end
