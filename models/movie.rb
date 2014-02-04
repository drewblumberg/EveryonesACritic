require_relative 'genre'
require_relative 'review'
require 'pry'

class Movie
  attr_accessor :name, :year, :length, :budget, :mpaa, :genre, :aggregateRating, :totalReviews
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
  end

  def self.create(attributes = {})
    movie = Movie.new(attributes)
    movie.save
    movie
  end

  def save
    db = Environment.database_connection
    unless genre.is_a? Integer
      genre_obj = Genre.new(genre) 
      genreID = genre_obj.parse_id
    else
      genreID = genre
    end

    if id
      if aggregateRating and totalReviews
        db.execute "UPDATE movies SET title = '#{name}', year = #{year}, length = #{length}, budget = #{budget}, mpaa = '#{mpaa}', genreID = #{genreID}, aggregateRating = #{aggregateRating}, totalReviews = #{totalReviews} WHERE CAST(movieID AS INTEGER)=#{id}"
      else
        db.execute "UPDATE movies SET title = '#{name}', year = #{year}, length = #{length}, budget = #{budget}, mpaa = '#{mpaa}', genreID = #{genreID}, aggregateRating = NULL, totalReviews = NULL WHERE CAST(movieID AS INTEGER)=#{id}"
      end
      success = true
    else
      movie_row = db.execute "SELECT * FROM movies WHERE CAST(title AS varchar)='#{name}'"

      if movie_row.length == 0
        totalMovieIDs = db.execute "SELECT COUNT(*) FROM movies"
        @id ||= totalMovieIDs[0][0] + 1
        db.execute "INSERT INTO movies(movieID,title,year,length,budget,aggregateRating,totalReviews,mpaa,genreID) VALUES (#{@id},'#{name}',#{year},#{length},#{budget},NULL,NULL,'#{mpaa}',#{genreID})"
        success = true
      else
        success = false
      end
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
      genre_obj = Genre.new(movie.genre)
      movie.send("id=", result["movieID"])
      movie
    else
      nil
    end
  end

  def self.find_by_id id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute "SELECT * FROM movies WHERE CAST(movies.movieID AS INTEGER)=#{id}"
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

  def self.all order, constraint = nil, value = nil
    database = Environment.database_connection
    database.results_as_hash = true
    if order and ["movieID", "title", "year", "length", "budget", "mpaa", "genreID", "aggregateRating", "totalReviews"].include?(order)
      orderby = "#{order}"
    else
      orderby = "title"
    end

    results = "SELECT * FROM movies"

    unless constraint.nil?
      if ['year', 'length', 'budget', 'totalReviews'].include?(constraint)
        results << " WHERE CAST(#{constraint} AS INTEGER)= #{value}"
      elsif ['title', 'mpaa']
        results << " WHERE CAST(#{constraint} AS VARCHAR)= '#{value}'"
      elsif ['aggregateRating'].include?(constraint)
        results << " WHERE CAST(#{constraint} AS REAL)= #{value}"
      else
        results << ""
      end
    end

    if ["aggregateRating", "budget", "totalReviews"].include?(orderby)
      results << " ORDER BY #{orderby} DESC"
    else
      results << " ORDER BY #{orderby} ASC"
    end

    results = database.execute results

    results.map do |row_hash|
      movie = Movie.new(name: row_hash["title"], year: row_hash["year"], length: row_hash["length"], budget: row_hash["budget"], mpaa: row_hash["mpaa"], genre: row_hash["genreID"], aggregateRating: row_hash["aggregateRating"], totalReviews: row_hash["totalReviews"])      
      movie.send("id=", row_hash["movieID"])
      genre_name = Genre.parse_name(movie.genre)
      formatted_movie = "[#{movie.id}] | #{movie.name} | #{movie.aggregateRating} | #{movie.totalReviews} | #{movie.year} | #{movie.length} | #{movie.budget} | #{genre_name} | #{movie.mpaa}"
    end
  end

  def update attributes = {}
    update_attributes(attributes)
    save
  end

  protected

  def id=(id)
    @id = id
  end

  def update_attributes(attributes)
    [:name, :year, :length, :budget, :mpaa, :genre, :aggregateRating, :totalReviews].each do |attr|
      if attributes[attr]
        if attr == :genre and !attributes[attr].is_a? Integer
          updated_genre = Genre.new(attributes[:genre])
          self.send("#{attr}=", updated_genre.parse_id)
        else
          self.send("#{attr}=", attributes[attr])
        end
      end
    end
  end
end