require_relative 'helper'
require_relative '../models/movie'

class TestMovie < MovieTest

  def test_saved_purchases_are_saved
    movie = Movie.new(name: "Anchorman2", genre: 4, year: 2013, length: 100, budget: 20000000, mpaa: "R")
    movies_before = database.execute("SELECT COUNT(movieID) from movies")[0][0]
    movie.save
    movies_after = database.execute("SELECT COUNT(movieID) from movies")[0][0]
    assert_equal movies_before + 1, movies_after 
  end

  def test_save_creates_an_id
    movie = Movie.create(name: "Anchorman2", genre: 4, year: 2013, length: 100, budget: 20000000, mpaa: "R")
    refute_nil movie.id, "Movie id should not be nil"
  end
end