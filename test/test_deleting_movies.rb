require_relative 'helper'

class TestDeletingMovies < MovieTest
  def test_delete_movie
    `./eac create movie Anchorman2 --genre "comedy" --year 2013 --length 100 --budget 20000000 --mpaa R --environment test`
    command = './eac delete movie "Anchorman2" --environment test'
    expected = 'The movie "Anchorman2" has been deleted from the database.'
    assert_command_output expected, command
  end

  def test_delete_movie_returns_similar
    skip
    command = './eac delete movie "Matrix" --environment test'
    expected = "No movie found.\nDid you mean: \nAnimatrix: Final Flight of the Osiris The, Matrix Reloaded The, Matrix Revolutions The, Matrix The, Sex Files: Sexual Matrix, That 70s Matrix"
    assert_command_output expected, command
  end
end