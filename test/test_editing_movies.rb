require_relative 'helper'
require_relative '../models/movie'
require_relative '../lib/environment'

class TestEditingMovies < MovieTest
  def test_updating_a_movie_that_exists
    `./eac create movie Anchorman2 --genre 4 --year 2013 --length 100 --budget 20000000 --mpaa R --environment test`
    movie = Movie.find('Anchorman2')
    id = movie.id
    command = "./eac edit movie --id #{id} --name 'Anchorman3' --budget 30000000 --environment test"
    expected = "A movie was updated and is now titled Anchorman3 with genre 4, year 2013, length 100, budget 30000000, and mpaa R was created."
    assert_command_output expected, command
  end

  def test_attempting_to_update_a_nonexistant_record
    command = "./eac edit movie --id 218903123980123  --name 'Anchorman3' --budget 30000000 --environment test"
    expected = "Movie 218903123980123 couldn't be found."
    assert_command_output expected, command
  end

  def test_attempting_to_update_with_no_changes
    `./eac create movie Anchorman2 --genre 4 --year 2013 --length 100 --budget 20000000 --mpaa R --environment test`
    movie = Movie.find('Anchorman2')
    id = movie.id
    command = "./eac edit movie --id #{id} --name 'Anchorman2' --budget 20000000 --environment test"
    expected = "A movie was updated and is now titled Anchorman2 with genre 4, year 2013, length 100, budget 20000000, and mpaa R was created."
    assert_command_output expected, command
  end
end