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

ActiveRecord::Schema.define(:version => 20111207022257) do

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.text     "bio"
    t.string   "genre"
    t.string   "hometown"
    t.integer  "hound_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.float    "hound_progress"
    t.text     "hound_meta"
  end

  create_table "images", :force => true do |t|
    t.string   "caption"
    t.string   "thumb_url"
    t.string   "full_url"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracks", :force => true do |t|
    t.string   "title"
    t.string   "stream_url"
    t.string   "download_url"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tracks", ["artist_id"], :name => "index_tracks_on_artist_id"

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.text     "embed_html"
    t.string   "download_url"
    t.string   "thumb_url"
    t.string   "src_url"
    t.integer  "artist_id"
    t.text     "hound_meta"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["artist_id"], :name => "index_videos_on_artist_id"

end
