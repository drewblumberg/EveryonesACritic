require_relative 'helper'
require 'sqlite3'

class TestEnteringMovies < MiniTest::Unit::TestCase
  def test_valid_movie_information_gets_printed
    command = "./eac create movie Anchorman2 --genre Comedy --year 2013 --length 100 --budget 20000000 --mpaa R"
    expected = "Theoretically creating: a movie titled Anchorman2 with genre Comedy, year 2013, length 100, budget 20000000, and mpaa R"
    assert_command_output expected, command
  end

  def test_valid_movie_gets_saved
    skip "needs implementation"
    assert false, "Missing test implementation"
  end

  def test_invalid_movie_doesnt_get_saved
    skip "needs implementation"
    assert false, "Missing test implementation"
  end
end