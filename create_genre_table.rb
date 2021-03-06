require 'sqlite3'

db = SQLite3::Database.new "./db/eac_production.sqlite3"

# db.execute <<-SQL
#   drop table genres;
# SQL

# db.execute <<-SQL
#   create table genres (
#     id int PRIMARY KEY,
#     action int,
#     animation int,
#     comedy int,
#     drama int,
#     documentary int,
#     romance int,
#     short int
#   );
# SQL

$MAX_GENRE_TYPES = 127
all_genres = []

$MAX_GENRE_TYPES.times do |index|
  genres = []
  index = index + 1

  genres.push(index)
  binary_vals = index.to_s(2).reverse.split('')

  7.times do |bin|
    if binary_vals[bin]
      genres.push(binary_vals[bin].to_i)
    else
      genres.push(0)
    end
  end
  all_genres.push(genres)
end

all_genres.each do |genre|
  db.execute "INSERT INTO genres values ( ?, ?, ?, ?, ?, ?, ?, ? )", genre
end