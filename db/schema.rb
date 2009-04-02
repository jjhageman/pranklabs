# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090304003003) do

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.integer  "prank_id"
    t.integer  "user_id"
    t.boolean  "profile"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_pranks", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "prank_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "prank_id"
    t.integer  "image_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "prank_id"
    t.string   "content_type",   :limit => 100
    t.string   "filename"
    t.string   "path"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.boolean  "primary"
    t.integer  "user_id"
    t.integer  "album_id"
    t.integer  "comments_count",                :default => 0, :null => false
    t.integer  "author_id"
  end

  create_table "pranks", :force => true do |t|
    t.string   "title"
    t.text     "summary"
    t.text     "tools"
    t.text     "targets"
    t.text     "instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "photos_count",                                                 :default => 0
    t.integer  "user_id"
    t.integer  "comments_count",                                               :default => 0, :null => false
    t.integer  "rating_count"
    t.integer  "rating_total",    :limit => 10, :precision => 10, :scale => 0
    t.decimal  "rating_avg",                    :precision => 10, :scale => 2
    t.string   "cached_tag_list"
  end

  create_table "rating_statistics", :force => true do |t|
    t.integer "rated_id"
    t.string  "rated_type"
    t.integer "rating_count"
    t.integer "rating_total", :limit => 10, :precision => 10, :scale => 0
    t.decimal "rating_avg",                 :precision => 10, :scale => 2
  end

  add_index "rating_statistics", ["rated_type", "rated_id"], :name => "index_rating_statistics_on_rated_type_and_rated_id"

  create_table "ratings", :force => true do |t|
    t.integer "rater_id"
    t.integer "rated_id"
    t.string  "rated_type"
    t.integer "rating",     :limit => 10, :precision => 10, :scale => 0
  end

  add_index "ratings", ["rated_type", "rated_id"], :name => "index_ratings_on_rated_type_and_rated_id"
  add_index "ratings", ["rater_id"], :name => "index_ratings_on_rater_id"

  create_table "stats_ratings", :force => true do |t|
    t.integer "rater_id"
    t.integer "rated_id"
    t.string  "rated_type"
    t.integer "rating",     :limit => 10, :precision => 10, :scale => 0
  end

  add_index "stats_ratings", ["rated_type", "rated_id"], :name => "index_stats_ratings_on_rated_type_and_rated_id"
  add_index "stats_ratings", ["rater_id"], :name => "index_stats_ratings_on_rater_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.boolean  "admin",                                   :default => false,     :null => false
    t.boolean  "enabled",                                 :default => true,      :null => false
    t.datetime "last_login_at"
    t.string   "state",                                   :default => "passive"
    t.datetime "deleted_at"
    t.string   "password_reset_code",       :limit => 40
    t.integer  "pranks_count",                            :default => 0,         :null => false
    t.integer  "comments_count",                          :default => 0,         :null => false
    t.integer  "albums_count",                            :default => 0,         :null => false
  end

end