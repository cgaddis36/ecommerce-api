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

ActiveRecord::Schema[7.0].define(version: 2022_12_15_192212) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.bigint "item_size_color_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["item_size_color_id"], name: "index_cart_items_on_item_size_color_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "item_count"
    t.float "total_weight"
    t.string "shipping_zip_code"
    t.float "estimated_shipping"
    t.float "item_subtotal"
    t.float "discount"
    t.float "tax"
    t.float "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.integer "role", default: 0
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_size_colors", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "size_id", null: false
    t.bigint "color_id", null: false
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["color_id"], name: "index_item_size_colors_on_color_id"
    t.index ["item_id"], name: "index_item_size_colors_on_item_id"
    t.index ["size_id"], name: "index_item_size_colors_on_size_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "stock"
    t.float "price"
    t.float "discount"
    t.integer "subcategory", default: 0
    t.string "images", default: [], array: true
    t.string "material", default: [], array: true
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_items_on_category_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "item_size_color_id", null: false
    t.integer "quantity"
    t.float "price"
    t.float "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_size_color_id"], name: "index_order_items_on_item_size_color_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "item_count"
    t.float "total_weight"
    t.string "shipping_first_name"
    t.string "shipping_last_name"
    t.string "shipping_address1"
    t.string "shipping_address2"
    t.string "shipping_city"
    t.string "shipping_state"
    t.string "shipping_zip_code"
    t.float "shipping_price"
    t.float "item_subtotal"
    t.float "tax"
    t.float "total"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer "role", default: 0
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "item_size_colors"
  add_foreign_key "carts", "users"
  add_foreign_key "item_size_colors", "colors"
  add_foreign_key "item_size_colors", "items"
  add_foreign_key "item_size_colors", "sizes"
  add_foreign_key "items", "categories"
  add_foreign_key "order_items", "item_size_colors"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "users"
end
