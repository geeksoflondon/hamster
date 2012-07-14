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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120713201618) do

  create_table "attendees", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "name"
    t.string   "phone_number"
    t.string   "twitter"
    t.integer  "tshirt"
    t.text     "diet"
    t.integer  "kind"
    t.boolean  "public",       :default => true
    t.text     "notes"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "attendees", ["kind"], :name => "index_attendees_on_kind"
  add_index "attendees", ["name"], :name => "index_attendees_on_name"

  create_table "emails", :force => true do |t|
    t.string   "address"
    t.integer  "attendee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "emails", ["address"], :name => "index_emails_on_address"
  add_index "emails", ["attendee_id"], :name => "index_emails_on_attendee_id"

  create_table "interactions", :force => true do |t|
    t.integer  "interactable_id"
    t.string   "interactable_type"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "interactions", ["interactable_id", "interactable_type", "key", "value"], :name => "complex_index"
  add_index "interactions", ["interactable_id", "interactable_type"], :name => "index_interactions_on_interactable_id_and_interactable_type"
  add_index "interactions", ["interactable_id"], :name => "index_interactions_on_interactable_id"
  add_index "interactions", ["interactable_type"], :name => "index_interactions_on_interactable_type"
  add_index "interactions", ["key", "value"], :name => "index_interactions_on_key_and_value"
  add_index "interactions", ["key"], :name => "index_interactions_on_key"
  add_index "interactions", ["value"], :name => "index_interactions_on_value"

  create_table "tickets", :force => true do |t|
    t.integer  "attendee_id"
    t.integer  "event_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tickets", ["attendee_id", "event_id"], :name => "index_tickets_on_attendee_id_and_event_id", :unique => true
  add_index "tickets", ["attendee_id"], :name => "index_tickets_on_attendee_id"
  add_index "tickets", ["event_id"], :name => "index_tickets_on_event_id"

end
