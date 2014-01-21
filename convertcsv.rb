require "sqlite3"
require 'csv'

db = SQLite3::Database.new "./data/critic.db"

db.execute <<-SQL
  drop table movies;
  drop table reviews;
SQL

db.execute <<-SQL
  create table reviews (
    reviewID int PRIMARY KEY,
    movieID int,
    review real
  );
SQL

rows = db.execute <<-SQL
  create table movies (
    movieID int PRIMARY KEY,
    title varchar(50),
    year int,
    length int,
    budget int,
    rating real,
    votes int,
    r1 real,
    r2 real,
    r3 real,
    r4 real,
    r5 real,
    r6 real,
    r7 real,
    r8 real,
    r9 real,
    r10 real,
    mpaa varchar(6),
    Action int,
    Adventure int,
    Comedy int,
    Drama int,
    Documentary int,
    Romance int,
    Short int
  );
SQL

CSV.foreach("./movies.csv", "rb") do |row|
  db.execute "insert into movies values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )", row
end