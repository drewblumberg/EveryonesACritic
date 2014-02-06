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

ActiveRecord::Schema.define(version: 20140205024000) do

  create_table "genres", id: false, force: true do |t|
    t.integer "genreID",     null: false
    t.integer "action"
    t.integer "animation"
    t.integer "comedy"
    t.integer "drama"
    t.integer "documentary"
    t.integer "romance"
    t.integer "short"
  end

  create_table "movies", id: false, force: true do |t|
    t.integer "movieID",         null: false
    t.string  "title"
    t.integer "year"
    t.integer "length"
    t.integer "budget"
    t.decimal "aggregateRating"
    t.integer "totalReviews"
    t.string  "mpaa"
    t.integer "genreID"
  end

  create_table "reviews", id: false, force: true do |t|
    t.integer "reviewID", null: false
    t.integer "movieID"
    t.decimal "review"
  end

end
