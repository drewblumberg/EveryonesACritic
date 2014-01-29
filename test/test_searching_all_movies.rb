require_relative 'helper'

class TestSearchingAllMovies < MovieTest
  def test_returns_helper_row
    command = "./eac list movie"
    expected = "[ID] | NAME | AGGREGATE RATING | TOTAL REVIEWS | YEAR | LENGTH | BUDGET | GENRE | MPAA"
    assert_command_output_includes expected, command
  end
end