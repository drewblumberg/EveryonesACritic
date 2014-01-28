require 'pry'

class Movie
  attr_accessor :name, :year, :length, :budget, :mpaa, :genre, :aggregateRating, :totalReviews
  attr_reader :id

  def initialize attributes = {}
    [:name, :year, :length, :budget, :mpaa, :genre, :aggregateRating, :totalReviews].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def save
    db = Environment.database_connection
    movie_row = db.execute "SELECT * FROM movies WHERE CAST(title AS varchar)='#{@name}'"

    if movie_row.length == 0
      totalMovieIDs = db.execute "SELECT COUNT(*) FROM movies"
      @id ||= totalMovieIDs[0][0] + 1
      db.execute "INSERT INTO movies(movieID,title,year,length,budget,aggregateRating,totalReviews,mpaa,genreID) VALUES (#{@id},'#{name}',#{year},#{length},#{budget},NULL,NULL,'#{mpaa}',#{genre})"
      success = true
    else
      success = false
    end

    success
  end

  def self.find_movie name
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute "SELECT * FROM movies WHERE CAST(title AS VARCHAR)='#{name}'"
    result = results[0]
    if result
      movie = Movie.new(name: result["title"], year: result["year"], length: result["length"], budget: result["budget"], mpaa: result["mpaa"], genre: result["genreID"], aggregateRating: result["aggregateRating"], totalReviews: result["totalReviews"])
      movie.send("id=", result["movieID"])
      movie
    else
      nil
    end
  end

  protected

  def id=(id)
    @id = id
  end
end