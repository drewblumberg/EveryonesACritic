require_relative 'helper'

class TestSearchingMovies < MovieTest
  def test_search_returns_movie
    command = './eac search "Matrix The" --environment test'
    expected = 'Matrix The (8.5 review score): a 1 released in 1999, it has a length of 136 minutes, a budget of $63000000, and is rated R.'
  end
end