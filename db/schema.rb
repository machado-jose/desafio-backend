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

ActiveRecord::Schema.define(version: 2022_04_27_234331) do

  create_table "deputies", force: :cascade do |t|
    t.string "name"
    t.string "ide_register"
    t.string "deputy_wallet_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "financial_management_deputy_expenses", force: :cascade do |t|
    t.integer "legislature_id", null: false
    t.string "sub_quota_number"
    t.string "sub_quota_description"
    t.string "sub_quota_specification_number"
    t.string "sub_quota_specification_description"
    t.string "provider"
    t.string "provider_registration_number"
    t.string "document_number"
    t.integer "document_type"
    t.datetime "issuance_date"
    t.decimal "document_value", precision: 8, scale: 2
    t.decimal "reverse_value", precision: 8, scale: 2
    t.decimal "net_value", precision: 8, scale: 2
    t.string "expense_month"
    t.string "expense_year"
    t.integer "installment_number"
    t.string "passager"
    t.string "leg_trip"
    t.string "batch_number"
    t.string "reimbursement_number"
    t.decimal "refund_value", precision: 8, scale: 2
    t.string "applicant_identifier"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "document_url"
    t.index ["legislature_id"], name: "index_financial_management_deputy_expenses_on_legislature_id"
  end

  create_table "financial_management_file_controls", force: :cascade do |t|
    t.string "expense_year"
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
    t.index ["deputy_id", "legislature_code"], name: "index_legislatures_on_deputy_id_and_legislature_code", unique: true
    t.index ["deputy_id"], name: "index_legislatures_on_deputy_id"
  end

  add_foreign_key "financial_management_deputy_expenses", "legislatures"
end
