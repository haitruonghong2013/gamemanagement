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

ActiveRecord::Schema.define(:version => 20140116092617) do

  create_table "character_bots", :force => true do |t|
    t.string   "char_name"
    t.integer  "gold"
    t.integer  "lv"
    t.float    "atk1"
    t.float    "atk2"
    t.float    "atk3"
    t.float    "def"
    t.integer  "hp"
    t.integer  "mp"
    t.integer  "medal"
    t.boolean  "char_gender"
    t.integer  "char_race"
    t.boolean  "online"
    t.boolean  "ban"
    t.integer  "win_number"
    t.integer  "lose_number"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "characters", :force => true do |t|
    t.integer  "user_id"
    t.string   "char_name"
    t.integer  "gold"
    t.integer  "lv"
    t.float    "atk1"
    t.float    "atk2"
    t.float    "atk3"
    t.float    "def"
    t.integer  "hp"
    t.integer  "mp"
    t.integer  "medal"
    t.boolean  "char_gender"
    t.integer  "char_race"
    t.boolean  "online"
    t.boolean  "ban"
    t.integer  "win_number"
    t.integer  "lose_number"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "life"
    t.float    "gem"
  end

  add_index "characters", ["id"], :name => "index_characters_on_id"

  create_table "item_groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "item_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.uuid     "item_group_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "level"
    t.float    "health"
    t.float    "atk"
    t.float    "def"
    t.uuid     "item_group_id"
    t.uuid     "item_type_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.float    "gold"
    t.float    "gem"
    t.float    "dam"
    t.float    "pc_dam"
    t.float    "pc_atk"
    t.boolean  "permanent"
    t.string   "image_name"
    t.float    "up_gem"
    t.float    "up_gold"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "races", :force => true do |t|
    t.float    "atk1"
    t.float    "atk2"
    t.float    "atk3"
    t.float    "def"
    t.integer  "hp"
    t.integer  "mp"
    t.integer  "char_race"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "scores", :force => true do |t|
    t.integer  "user_id"
    t.uuid     "character_id"
    t.datetime "time_stamp"
    t.float    "score"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "score_type"
  end

  create_table "sms_requests", :force => true do |t|
    t.string   "access_key"
    t.string   "command"
    t.string   "mo_message"
    t.string   "msisdn"
    t.string   "request_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "short_code"
    t.text     "signature"
    t.uuid     "character_id"
    t.datetime "request_time"
  end

  create_table "user_items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "level"
    t.float    "health"
    t.float    "atk"
    t.float    "def"
    t.integer  "user_id"
    t.uuid     "item_group_id"
    t.uuid     "item_type_id"
    t.uuid     "character_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.float    "dam"
    t.float    "pc_dam"
    t.float    "pc_atk"
    t.boolean  "permanent"
    t.float    "cur_health"
    t.uuid     "item_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                     :default => "",    :null => false
    t.string   "encrypted_password",        :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "authentication_token"
    t.integer  "organization_id"
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "telephone"
    t.string   "time_zone",                 :default => "UTC"
    t.string   "address"
    t.string   "apn_token"
    t.string   "area_code"
    t.string   "avatar"
    t.datetime "birthday"
    t.string   "city"
    t.string   "country"
    t.string   "cover"
    t.string   "created_date"
    t.string   "facebook_id"
    t.string   "gcm_token"
    t.string   "google_id"
    t.string   "language"
    t.string   "name"
    t.string   "note"
    t.string   "phone"
    t.boolean  "sex"
    t.string   "twitter_id"
    t.integer  "user_type"
    t.string   "avatar_thumb"
    t.string   "ubox_authentication_token"
    t.boolean  "is_login"
    t.string   "device_id"
    t.string   "ubox_id"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "versions", :force => true do |t|
    t.string   "name"
    t.float    "version"
    t.text     "description"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "download_url"
    t.string   "jar_file"
    t.string   "apk_file"
  end

end
