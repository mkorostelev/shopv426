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

ActiveRecord::Schema.define(version: 20160707184742) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auth_tokens", force: :cascade do |t|
    t.string   "value"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "auth_tokens", ["user_id"], name: "index_auth_tokens_on_user_id", using: :btree

  create_table "gift_certificates", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.integer  "amount",     default: 0
    t.string   "token"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "gift_certificates", ["order_id"], name: "index_gift_certificates_on_order_id", using: :btree
  add_index "gift_certificates", ["token"], name: "index_gift_certificates_on_token", unique: true, using: :btree
  add_index "gift_certificates", ["user_id"], name: "index_gift_certificates_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "amount",     default: 0
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order_id"
  end

  add_index "purchases", ["order_id"], name: "index_purchases_on_order_id", using: :btree
  add_index "purchases", ["product_id"], name: "index_purchases_on_product_id", using: :btree
  add_index "purchases", ["user_id"], name: "index_purchases_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "balance",         default: 0
    t.integer  "bonus_points",    default: 0
  end

  add_foreign_key "auth_tokens", "users"
  add_foreign_key "gift_certificates", "orders"
  add_foreign_key "gift_certificates", "users"
  add_foreign_key "orders", "users"
  add_foreign_key "purchases", "orders"
  add_foreign_key "purchases", "products"
  add_foreign_key "purchases", "users"
end
