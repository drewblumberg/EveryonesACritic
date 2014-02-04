require_relative 'helper'
require_relative '../models/movie'

class TestMovie < MovieTest

  def test_saved_purchases_are_saved
    movie = Movie.new(name: "Anchorman2", genre: "comedy", year: 2013, length: 100, budget: 20000000, mpaa: "R")
    movies_before = database.execute("SELECT COUNT(movieID) from movies")[0][0]
    movie.save
    movies_after = database.execute("SELECT COUNT(movieID) from movies")[0][0]
    assert_equal movies_before + 1, movies_after 
  end

  def test_save_creates_an_id
    movie = Movie.create(name: "Anchorman2", genre: "comedy", year: 2013, length: 100, budget: 20000000, mpaa: "R")
    refute_nil movie.id, "Movie id should not be nil"
  end

  def test_find_returns_nil_if_unfindable
    assert_nil Movie.find("ThisIsNotAMovieHere")
  end

  def test_find_returns_the_row_as_movie_object
    movie = Movie.create(name: "Anchorman2", genre: "comedy", year: 2013, length: 100, budget: 20000000, mpaa: "R")
    found = Movie.find("Anchorman2")
    assert_equal movie.name, found.name
    assert_equal movie.id, found.id
  end

  def test_delete_deletes_a_movie
    movie = Movie.create(name: "Anchorman2", genre: "comedy", year: 2013, length: 100, budget: 20000000, mpaa: "R")
    movies_before = database.execute("SELECT COUNT(movieID) from movies")[0][0]
    movie.delete
    movies_after = database.execute("SELECT COUNT(movieID) from movies")[0][0]
    assert_equal movies_before - 1, movies_after
  end

  def test_update_doesnt_insert_new_row
    movie = Movie.create(name: "Anchorman2", genre: "comedy", year: 2013, length: 100, budget: 20000000, mpaa: "R")
    movies_before = database.execute("SELECT COUNT(movieID) from movies")[0][0]
    movie.update(name: "Anchorman3")
    movies_after = database.execute("SELECT COUNT(movieID) from movies")[0][0]
    assert_equal movies_before, movies_after
  end

  def test_update_saves_to_the_database
    movie = Movie.create(name: "Anchorman2", genre: "comedy", year: 2013, length: 100, budget: 20000000, mpaa: "R")
    id = movie.id
    movie.update(name: "Anchorman3")
    updated_purchase = Movie.find_by_id(id)
    expected = ["Anchorman3"]
    actual = [ updated_purchase.name ]
    assert_equal expected, actual
  end

  def test_equality_on_same_object
    movie = Movie.create(name: "Anchorman2", genre: "comedy", year: 2013, length: 100, budget: 20000000, mpaa: "R")
    assert movie == movie
  end

  def test_equality_with_different_class
    movie = Movie.create(name: "Anchorman2", genre: "comedy", year: 2013, length: 100, budget: 20000000, mpaa: "R")
    refute movie == "Movie"
  end

  def test_equality_with_different_movie
    movie1 = Movie.create(name: "Anchorman2", genre: "comedy", year: 2013, length: 100, budget: 20000000, mpaa: "R")
    movie2 = Movie.create(name: "Anchorman3", genre: "comedy", year: 2013, length: 100, budget: 20000000, mpaa: "R")
    refute movie1 == movie2
  end
end