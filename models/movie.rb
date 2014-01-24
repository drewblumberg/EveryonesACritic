class Movie
  attr_accessor :name, :year, :length, :budget, :mpaa, :genre

  def initialize attributes = {}
    [:name, :year, :length, :budget, :mpaa, :genre].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def save
    db = Environment.database_connection
    movie_row = db.execute "SELECT * FROM movies WHERE CAST(title AS varchar)='Anchorman2'"

    if movie_row.length == 0
      totalMovieIDs = db.execute "SELECT COUNT(*) FROM movies"
      movieID = totalMovieIDs[0][0] + 1
      db.execute "INSERT INTO movies(movieID,title,year,length,budget,aggregateRating,totalReviews,mpaa,genreID) VALUES (#{movieID},'#{name}',#{year},#{length},#{budget},NULL,NULL,'#{mpaa}',#{genre})"
      success = true
    else
      success = false
    end

    success
  end
end