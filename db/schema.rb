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

ActiveRecord::Schema[7.1].define(version: 2024_01_25_032754) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "product_taxes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.bigint "tax_id"
    t.index ["product_id"], name: "index_product_taxes_on_product_id"
    t.index ["tax_id"], name: "index_product_taxes_on_tax_id"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "receipt_products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "receipt_id"
    t.bigint "product_id"
    t.integer "amount"
    t.decimal "price", precision: 10, scale: 2
    t.decimal "tax", precision: 10, scale: 2
    t.index ["product_id"], name: "index_receipt_products_on_product_id"
    t.index ["receipt_id"], name: "index_receipt_products_on_receipt_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "total_taxes", precision: 10, scale: 2
    t.decimal "total", precision: 10, scale: 2
  end

  create_table "taxes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.float "rate"
  end

end
