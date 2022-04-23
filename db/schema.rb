# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_04_23_212530) do

  create_table "deputies", force: :cascade do |t|
    t.string "name"
    t.string "ide_register"
    t.string "current_uf"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "legislatures", force: :cascade do |t|
    t.string "legislature_number"
    t.string "uf"
    t.string "party_acronym"
    t.string "legislature_code"
    t.integer "deputy_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deputy_id"], name: "index_legislatures_on_deputy_id"
  end

end
