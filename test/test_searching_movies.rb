require_relative 'helper'

class TestSearchingMovies < MovieTest
  def test_search_returns_movie
    command = './eac search movie "Matrix The" --environment test'
    expected = 'Matrix The (8.5 review score): a 1 released in 1999, it has a length of 136 minutes, a budget of $63000000, and is rated R.'
    assert_command_output expected, command
  end

  def test_search_returns_no_movie
    command = './eac search movie "asdfghjasdfghj" --environment test'
    expected = "No movie found with title 'asdfghjasdfghj'. Would you like to create one? Just use the command 'movie create'."
    assert_command_output expected, command
  end
end