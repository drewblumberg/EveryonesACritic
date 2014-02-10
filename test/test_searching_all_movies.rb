require_relative 'helper'

class TestSearchingAllMovies < MovieTest
  def test_returns_helper_row
    command = "./eac list movie"
    expected = "[ID] | NAME | AGGREGATE RATING | TOTAL REVIEWS | YEAR | LENGTH | BUDGET | GENRE | MPAA"
    assert_command_output_includes expected, command
  end

  def test_returns_movie_data
    command = "./eac list movie"
    expected = "[194] | 15 Minutes | 4.8 | 19 | 1999 | 25 | 0 | comedy-short | "
    assert_command_output_includes expected, command
  end
end