require_relative 'helper'
require_relative '../models/movie'

class TestMovie < MovieTest
  def test_save_creates_an_id
    movie = Movie.create(name: "Anchorman2", genre: 4, year: 2013, length: 100, budget: 20000000, mpaa: "R")
    refute_nil movie.id, "Movie id should not be nil"
  end
end