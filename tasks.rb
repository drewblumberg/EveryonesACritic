require "sqlite3"

db = SQLite3::Database.new "./db/eac_test.sqlite3"
db2 = SQLite3::Database.new "./db/eac_production.sqlite3"

db.execute <<-SQL
  ATTACH DATABASE 'db/critic.db' AS old_db;
  INSERT INTO genres(genreID, action, animation, comedy, drama, documentary, romance, short) SELECT * FROM old_db.genres;
  DETACH DATABASE old_db;
SQL

db.execute <<-SQL
  ATTACH DATABASE 'db/critic.db' AS old2_db;
  INSERT INTO movies(movieID,title,year,length,budget,aggregateRating,totalReviews,mpaa,genreID) SELECT * FROM old2_db.movies;
  DETACH DATABASE old2_db;
SQL

db2.execute <<-SQL
  ATTACH DATABASE 'db/critic.db' AS old3_db;
  INSERT INTO genres(genreID, action, animation, comedy, drama, documentary, romance, short) SELECT * FROM old3_db.genres;
  DETACH DATABASE old3_db;
SQL

db2.execute <<-SQL
  ATTACH DATABASE 'db/critic.db' AS old4_db;
  INSERT INTO movies(movieID,title,year,length,budget,aggregateRating,totalReviews,mpaa,genreID) SELECT * FROM old4_db.movies;
  DETACH DATABASE old4_db;
SQL


# db.execute <<-SQL
#   INSERT INTO movies(movieID,title,year,length,budget,aggregateRating,totalReviews,mpaa)
#   SELECT movieID,title,year,length,budget,rating,votes,mpaa
#   FROM tmp_movies;
# SQL

# all_values = []

# db.execute( "SELECT tm.Action,tm.Adventure,tm.Comedy,tm.Drama,tm.Documentary,tm.Romance,tm.Short FROM tmp_movies tm" ) do |row|
#   binary_val = 1 * row[0].to_i
#   binary_val += 2 * row[1].to_i
#   binary_val += 4 * row[2].to_i
#   binary_val += 8 * row[3].to_i
#   binary_val += 16 * row[4].to_i
#   binary_val += 32 * row[5].to_i
#   binary_val += 64 * row[6].to_i

#   all_values.push(binary_val)
# end

# all_values.each_with_index do |value, index|
#   index = index + 1
#   db.execute "UPDATE movies SET genreID=? WHERE CAST(movieID AS int)=?", value, index
# end
