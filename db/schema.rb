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

ActiveRecord::Schema.define(version: 20161207110850) do

  create_table "admins", force: :cascade do |t|
    t.string   "login"
    t.string   "password"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "ISBN",       null: false
    t.string   "title",      null: false
    t.string   "authors",    null: false
    t.integer  "copies",     null: false
    t.string   "subject",    null: false
    t.string   "thumbnail",  null: false
    t.integer  "year",       null: false
    t.integer  "price",      null: false
    t.string   "publisher",  null: false
    t.string   "keywords",   null: false
    t.string   "format",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "login",      null: false
    t.string   "password",   null: false
    t.string   "name",       null: false
    t.integer  "phone",      null: false
    t.string   "address",    null: false
    t.string   "CCN",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "opinions", force: :cascade do |t|
    t.integer  "score"
    t.text     "text"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "customer_id"
    t.integer  "book_id"
    t.index ["book_id"], name: "index_opinions_on_book_id"
    t.index ["customer_id"], name: "index_opinions_on_customer_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "copies",      null: false
    t.string   "status",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "customer_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.string   "usefulness"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "customer_id"
    t.integer  "book_id"
    t.integer  "rater_id"
    t.index ["book_id"], name: "index_ratings_on_book_id"
    t.index ["customer_id"], name: "index_ratings_on_customer_id"
    t.index ["rater_id"], name: "index_ratings_on_rater_id"
  end

end
