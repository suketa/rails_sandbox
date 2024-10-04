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

ActiveRecord::Schema[7.2].define(version: 2024_10_03_233142) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.bigint "employee_id", null: false, comment: "外部キー：従業員ID"
    t.bigint "project_id", null: false, comment: "外部キー：プロジェクトID"
    t.string "role", null: false, comment: "役割"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id", "project_id"], name: "index_assignments_on_employee_id_and_project_id", unique: true
    t.index ["employee_id"], name: "index_assignments_on_employee_id"
    t.index ["project_id"], name: "index_assignments_on_project_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false, comment: "部署名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name", null: false, comment: "名前"
    t.integer "age", null: false, comment: "年齢"
    t.bigint "department_id", null: false, comment: "外部キー：所属部署ID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_employees_on_department_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false, comment: "プロジェクト名"
    t.date "start_date", null: false, comment: "開始日"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "assignments", "employees"
  add_foreign_key "assignments", "projects"
  add_foreign_key "employees", "departments"
end
