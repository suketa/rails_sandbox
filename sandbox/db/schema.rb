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

ActiveRecord::Schema[7.2].define(version: 2024_10_17_232218) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", comment: "カテゴリ", force: :cascade do |t|
    t.string "name", null: false, comment: "カテゴリ名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "tasks", comment: "タスク", force: :cascade do |t|
    t.string "title", null: false, comment: "タイトル"
    t.text "description", comment: "詳細"
    t.date "due_date", comment: "締め切り"
    t.integer "status", default: 0, null: false, comment: "状態：未着手, 進行中, 完了"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_tasks_on_category_id"
  end

  add_foreign_key "tasks", "categories"
end
