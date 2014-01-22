require_relative 'helper'

class TestEnteringMovies < MiniTest::Unit::TestCase
  def test_valid_movie_information_gets_printed
    command = "./eac create movie --title Anchorman2 --genre 4 --year 2013 --length 100 --budget 20000000 --mpaa R"
    expected = "Theoretically creating: a movie titled Anchorman2 with genre Comedy, year 2013, length 100, budget 20000000, and mpaa R"
    assert_command_output expected, command
  end
end