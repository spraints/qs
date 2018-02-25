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

ActiveRecord::Schema.define(version: 20141227154103) do

  create_table "metrics", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_metrics_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",                  null: false
    t.string   "uid",                       null: false
    t.string   "username",                  null: false
    t.boolean  "enabled",    default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid"
    t.index ["provider", "username"], name: "index_users_on_provider_and_username", unique: true
  end

  create_table "values", force: :cascade do |t|
    t.integer  "metric_id"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["metric_id"], name: "index_values_on_metric_id"
  end

end
