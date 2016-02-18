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

ActiveRecord::Schema.define(version: 20160218180549) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "role"
    t.string   "locale"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "admin_users", ["organization_id"], name: "index_admin_users_on_organization_id", using: :btree

  create_table "answers", force: :cascade do |t|
    t.jsonb    "value"
    t.integer  "response_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["response_id"], name: "index_answers_on_response_id", using: :btree

  create_table "google_api_authorizations", force: :cascade do |t|
    t.integer  "questionnaire_id"
    t.jsonb    "token",            default: {}
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "google_api_authorizations", ["questionnaire_id"], name: "index_google_api_authorizations_on_questionnaire_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_index "organizations", ["deleted_at"], name: "index_organizations_on_deleted_at", using: :btree

  create_table "questionnaires", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "title"
    t.string   "locale"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "time_zone"
    t.string   "domain"
    t.boolean  "email_required",           default: true
    t.string   "mode"
    t.integer  "starting_balance"
    t.integer  "maximum_deviation"
    t.integer  "default_assessment"
    t.string   "assessment_period",        default: "month"
    t.decimal  "tax_rate"
    t.integer  "tax_revenue"
    t.boolean  "change_required"
    t.string   "logo"
    t.string   "title_image"
    t.text     "introduction"
    t.string   "instructions"
    t.string   "read_more"
    t.string   "content_before"
    t.string   "content_after"
    t.string   "description"
    t.string   "attribution"
    t.string   "stylesheet"
    t.string   "javascript"
    t.string   "reply_to"
    t.string   "thank_you_subject"
    t.text     "thank_you_template"
    t.string   "response_notice"
    t.string   "response_preamble"
    t.string   "response_body"
    t.string   "google_analytics"
    t.string   "google_analytics_profile"
    t.string   "twitter_screen_name"
    t.string   "twitter_text"
    t.string   "twitter_share_text"
    t.string   "facebook_app_id"
    t.string   "open_graph_title"
    t.string   "open_graph_description"
    t.string   "authorization_token"
    t.integer  "logo_width"
    t.integer  "logo_height"
    t.integer  "title_image_width"
    t.integer  "title_image_height"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.datetime "deleted_at"
  end

  add_index "questionnaires", ["deleted_at"], name: "index_questionnaires_on_deleted_at", using: :btree
  add_index "questionnaires", ["domain"], name: "index_questionnaires_on_domain", using: :btree
  add_index "questionnaires", ["organization_id"], name: "index_questionnaires_on_organization_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.integer  "section_id"
    t.string   "title"
    t.text     "description"
    t.integer  "default_value"
    t.integer  "size"
    t.integer  "maxlength"
    t.string   "placeholder"
    t.integer  "rows"
    t.integer  "cols"
    t.boolean  "required"
    t.boolean  "revenue"
    t.string   "widget"
    t.text     "extra"
    t.text     "embed"
    t.decimal  "unit_amount"
    t.string   "unit_name"
    t.integer  "position"
    t.text     "options",       default: [],              array: true
    t.text     "labels",        default: [],              array: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "minimum_units"
    t.integer  "maximum_units"
    t.integer  "step"
  end

  add_index "questions", ["position"], name: "index_questions_on_position", using: :btree
  add_index "questions", ["section_id"], name: "index_questions_on_section_id", using: :btree

  create_table "responses", force: :cascade do |t|
    t.integer  "questionnaire_id"
    t.datetime "initialized_at"
    t.string   "ip"
    t.decimal  "assessment"
    t.string   "comments"
    t.string   "email"
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "deleted_at"
  end

  add_index "responses", ["deleted_at"], name: "index_responses_on_deleted_at", using: :btree

  create_table "sections", force: :cascade do |t|
    t.integer  "questionnaire_id"
    t.string   "title"
    t.string   "description"
    t.string   "extra"
    t.string   "embed"
    t.string   "group"
    t.integer  "position"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "sections", ["position"], name: "index_sections_on_position", using: :btree
  add_index "sections", ["questionnaire_id"], name: "index_sections_on_questionnaire_id", using: :btree

end
