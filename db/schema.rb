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

ActiveRecord::Schema.define(version: 20130627132654) do

  create_table "clients", force: true do |t|
    t.string   "name"
    t.float    "hourly_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoice_items", force: true do |t|
    t.integer  "client_id"
    t.integer  "invoice_id"
    t.date     "date"
    t.time     "start"
    t.time     "finish"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "petrol",     default: 0.0
  end

  create_table "invoices", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "month",      limit: 20
    t.integer  "year"
  end

end
