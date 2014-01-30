require 'pry'

class Movie
  attr_accessor :name, :year, :length, :budget, :mpaa, :genre, :aggregateRating, :totalReviews
  attr_reader :id

  def initialize attributes = {}
    [:name, :year, :length, :budget, :mpaa, :genre, :aggregateRating, :totalReviews].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def self.create(attributes = {})
    movie = Movie.new(attributes)
    movie.save
    movie
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

  def delete
    db = Environment.database_connection
    db.execute "DELETE FROM movies WHERE CAST(title AS varchar)='#{@name}'"
  end

  def self.find name
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

  def self.find_similar name
    database = Environment.database_connection
    database.results_as_hash = true
    similar = database.execute "SELECT * FROM movies WHERE CAST(title AS VARCHAR) LIKE '%#{name}%'"
    similar_titles = []
    similar.each do |movie|
      similar_titles << movie["title"]
    end
    similar_titles
  end

  def self.all order
    database = Environment.database_connection
    database.results_as_hash = true
    if order and ["movieID", "title", "year", "length", "budget", "mpaa", "genreID", "aggregateRating", "totalReviews"].include?(order)
      orderby = "#{order}"
    else
      orderby = "title"
    end

    if ["aggregateRating", "budget", "totalReviews"].include?(orderby)
      results = database.execute("SELECT * FROM movies ORDER BY #{orderby} DESC")
    else
      results = database.execute("SELECT * FROM movies ORDER BY #{orderby} ASC")
    end

    results.map do |row_hash|
      movie = Movie.new(name: row_hash["title"], year: row_hash["year"], length: row_hash["length"], budget: row_hash["budget"], mpaa: row_hash["mpaa"], genre: row_hash["genreID"], aggregateRating: row_hash["aggregateRating"], totalReviews: row_hash["totalReviews"])      
      movie.send("id=", row_hash["movieID"])
      formatted_movie = "[#{movie.id}] | #{movie.name} | #{movie.aggregateRating} | #{movie.totalReviews} | #{movie.year} | #{movie.length} | #{movie.budget} | #{movie.genre} | #{movie.mpaa}"
    end
  end

  protected

  def id=(id)
    @id = id
  end
end