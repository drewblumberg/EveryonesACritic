require_relative 'helper'

class TestDeletingMovies < MovieTest
  def test_delete_movie
    `./eac create movie Anchorman2 --genre 4 --year 2013 --length 100 --budget 20000000 --mpaa R --environment test`
    command = './eac delete movie "Anchorman2" --environment test'
    expected = 'The movie "Anchorman2" has been deleted from the database.'
    assert_command_output expected, command
  end
end