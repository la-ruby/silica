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

ActiveRecord::Schema.define(version: 2022_04_05_003227) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addendum_versions", force: :cascade do |t|
    t.integer "version"
    t.string "expiration"
    t.string "deadline"
    t.text "terms"
    t.string "status"
    t.bigint "addendum_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "docusign_envelope_id"
    t.string "signed_by_company_at"
    t.string "sent_to_seller_at"
    t.string "accepted_at"
    t.string "rejected_at"
    t.string "rejected_feedback"
    t.string "mop_token"
    t.integer "related_repc_id"
    t.string "second_seller_accepted_at"
    t.string "second_seller_rejected_at"
    t.text "second_seller_rejected_feedback"
    t.index ["addendum_id"], name: "index_addendum_versions_on_addendum_id"
  end

  create_table "addendums", force: :cascade do |t|
    t.integer "addendum_number"
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_addendums_on_project_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_mobile"
    t.string "phone_work"
    t.string "email"
    t.string "investing_location"
    t.string "sendgrid_created_at"
    t.string "sendgrid_created_at_searchable"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "examples", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.boolean "seed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "listing_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["listing_id"], name: "index_favorites_on_listing_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "intake_forms", force: :cascade do |t|
    t.string "completed"
    t.integer "project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "what_type_of_property_is_this"
    t.string "who_is_the_purchaser"
    t.string "property_analysis"
    t.text "internal_summary_for_dispositions"
    t.string "disposition_plan"
    t.string "does_the_property_have_current_tenants"
    t.string "are_those_tenants_staying"
    t.string "do_rent_rates_need_to_be_adjusted"
    t.string "if_so_what_is_the_new_rate"
    t.string "does_the_property_need_water_power"
    t.string "who_will_pay_for_water_power"
    t.string "does_the_property_need_to_be_cleaned"
    t.string "is_the_property_in_an_hoa"
    t.string "if_there_is_an_hoa_who_is_the_contact"
    t.string "is_this_property_being_listed_as_is"
    t.text "what_repairs_need_to_be_managed_by_company"
    t.string "what_is_the_budget_for_required_repairs"
    t.text "other_notes"
  end

  create_table "kodaks", force: :cascade do |t|
    t.string "primary", default: "0"
    t.string "marketplace", default: "0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "project_id", null: false
    t.index ["project_id"], name: "index_kodaks_on_project_id"
  end

  create_table "listings", force: :cascade do |t|
    t.integer "project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "beds"
    t.integer "baths"
    t.integer "price"
    t.string "address"
    t.float "lat"
    t.float "lng"
    t.string "title"
    t.text "legacy_description"
    t.string "walkthrough_date"
    t.string "walkthrough_time"
    t.string "walkthrough_schedule_email"
    t.string "walkthrough_schedule_email_send_now"
    t.string "marketing_email"
    t.string "marketing_email_send_now"
    t.string "property_type"
    t.string "price_sqft"
    t.string "hoa_fees"
    t.string "heating"
    t.string "sqft"
    t.string "owner_occupied"
    t.string "cooling"
    t.string "year"
    t.string "lot_size"
    t.string "down_payment"
    t.string "monthly_payment"
    t.string "term_length"
    t.string "estimated_remaining_mortgage"
    t.string "interest_rate"
    t.string "balloon_payment"
    t.string "listed"
    t.integer "suggested_price"
    t.string "webflow_id"
    t.string "opportunity_type", default: "opportunity_investment"
  end

  create_table "projects", force: :cascade do |t|
    t.string "status"
    t.string "direction"
    t.string "source"
    t.datetime "addendum_sent", precision: 6
    t.datetime "offer_accepted", precision: 6
    t.datetime "offer_viewed", precision: 6
    t.datetime "offer_sent", precision: 6
    t.datetime "req_date", precision: 6
    t.string "city"
    t.string "state"
    t.string "street"
    t.string "zip"
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "expectedtimeline"
    t.string "street_searchable"
    t.text "searchable"
    t.string "secondName"
    t.string "secondPhone"
    t.string "secondEmail"
    t.datetime "created_at", precision: 6, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "now()" }, null: false
    t.string "token"
    t.string "envelope_id"
    t.float "beds"
    t.float "baths"
    t.string "sqft"
    t.string "year"
    t.string "plot"
    t.text "underwriting_notes_for_sales"
    t.string "assignment_fee"
    t.text "sales_notes_for_underwriting"
    t.string "lender_1"
    t.string "lender_2"
    t.string "property_type"
    t.string "price_sqft"
    t.string "hoa_fees"
    t.string "heating"
    t.string "cooling"
    t.string "lot_size"
    t.string "owner_occupied"
    t.string "agreed_to_terms_at"
    t.string "street2"
    t.string "accepted_at"
    t.string "sendgrid_message_id"
    t.string "analysis_url", default: "https://silica-bucket.s3.amazonaws.com/neutral/neutral/empty.pdf"
    t.string "analysis_at"
    t.text "scout"
    t.string "scout_sent_at"
  end

  create_table "property_disposition_checklists", force: :cascade do |t|
    t.string "property_address"
    t.string "owner_contact_info"
    t.string "summary_of_deal"
    t.string "copy_of_repc"
    t.string "acquire_property_insurance"
    t.string "connect_with_preferred"
    t.text "connect_with_preferred_textarea"
    t.string "upload_proof_of_insurance"
    t.string "submit_all_closing_docs"
    t.string "settlement_statement"
    t.string "loan_documents"
    t.string "financial_records"
    t.string "receipts"
    t.string "send_notice_of"
    t.string "how_and_when"
    t.string "who_tenants_can_contact"
    t.string "date_updates_sent"
    t.string "date_updates_sent_dateinput"
    t.string "send_out_new"
    t.string "send_out_new_dateinput"
    t.string "send_out_a_notice_to_vacate"
    t.string "send_out_a_notice_to_vacate_dateinput"
    t.string "coordinate_to_have"
    t.string "coordinate_with_property"
    t.string "connect_with_agent"
    t.string "connect_with_agent_dateinput"
    t.string "important_notes_for"
    t.text "important_notes_for_textarea"
    t.string "once_property_is_sold"
    t.string "stop_utility"
    t.string "date_utilities_stopped"
    t.string "date_utilities_stopped_dateinput"
    t.string "all_insurance_canceled"
    t.string "all_insurance_canceled_dateinput"
    t.integer "project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "repcs", force: :cascade do |t|
    t.string "earnest_money"
    t.string "agreement_date"
    t.string "settlement_date"
    t.text "notes"
    t.string "closing_costs_paid_by"
    t.string "offer_terms"
    t.string "down_payment"
    t.string "term_length"
    t.string "interest_rate"
    t.string "monthly_payment"
    t.string "estimated_remaining_mortgage"
    t.string "balloon_payment"
    t.string "real_estate_professional"
    t.integer "project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "version"
    t.text "rejected_feedback"
    t.string "rejected_at"
    t.string "mop_token"
    t.string "mop_token_secondary"
    t.string "accepted_at"
    t.string "docusign_envelope_id"
    t.string "sent_homeowner_at"
    t.string "inspection_period_deadline"
    t.string "possession_date"
    t.string "signed_by_company_at"
    t.string "second_seller_accepted_at"
    t.string "second_seller_rejected_at"
    t.text "second_seller_rejected_feedback"
    t.string "closing_costs"
    t.string "repair_costs"
    t.string "service_fee"
    t.string "company_offer_arv"
    t.string "legal_description"
    t.string "title_company"
    t.string "service_fee_is_percentage"
    t.string "mutable", default: "1"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addendums", "projects"
  add_foreign_key "favorites", "listings"
  add_foreign_key "favorites", "users"
  add_foreign_key "kodaks", "projects"
end
