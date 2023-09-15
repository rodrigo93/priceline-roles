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

ActiveRecord::Schema[7.0].define(version: 2023_09_15_144612) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "memberships", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "team_id", null: false
    t.string "user_id", null: false
    t.index ["role_id"], name: "index_memberships_on_role_id"
    t.index ["team_id", "user_id"], name: "index_memberships_on_team_id_and_user_id", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  add_foreign_key "memberships", "roles"
end
