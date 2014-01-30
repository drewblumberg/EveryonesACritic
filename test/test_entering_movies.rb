require_relative 'helper'
require_relative '../lib/environment'

class TestEnteringMovies < MovieTest
  def test_valid_movie_information_gets_printed
    command = "./eac create movie Anchorman2 --genre 4 --year 2013 --length 100 --budget 20000000 --mpaa R --environment test"
    expected = "A movie titled Anchorman2 with genre 4, year 2013, length 100, budget 20000000, and mpaa R was created."
    assert_command_output expected, command
  end

  def test_valid_movie_gets_saved
    # Current movie numbers
    orig_movies = database.execute "SELECT COUNT(*) FROM movies"

    `./eac create movie Anchorman2 --genre 4 --year 2013 --length 100 --budget 20000000 --mpaa R --environment test`
    results = database.execute "SELECT title,year,length,budget,mpaa FROM movies WHERE title='Anchorman2'"
    expected = ["Anchorman2", 2013, 100, 20000000, "R"]
    assert_equal expected, results[0]

    result = database.execute "SELECT COUNT(*) FROM movies"
    assert_equal (orig_movies[0][0] + 1), result[0][0]
  end

  def test_invalid_movie_doesnt_get_saved
    # Current movie numbers
    orig_movies = database.execute "SELECT COUNT(*) FROM movies"

    command = "./eac create movie Anchorman2"
    expected = "You must provide the genre and year and length and budget and mpaa of the movie you are adding."
    assert_command_output expected, command

    result = database.execute "SELECT COUNT(*) FROM movies"
    assert_equal orig_movies[0][0], result[0][0]
  end

  def test_error_message_for_missing_genre
    command = "./eac create movie Anchorman2 --year 2013 --length 100 --budget 20000000 --mpaa R --environment test"
    expected = "You must provide the genre of the movie you are adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_year
    command = "./eac create movie Anchorman2 --genre 4 --length 100 --budget 20000000 --mpaa R --environment test"
    expected = "You must provide the year of the movie you are adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_length
    command = "./eac create movie Anchorman2 --genre 4 --year 2013 --budget 20000000 --mpaa R --environment test"
    expected = "You must provide the length of the movie you are adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_budget
    command = "./eac create movie Anchorman2 --year 2013 --length 100 --genre 4 --mpaa R --environment test"
    expected = "You must provide the budget of the movie you are adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_mpaa
    command = "./eac create movie Anchorman2 --year 2013 --length 100 --budget 20000000 --genre 4 --environment test"
    expected = "You must provide the mpaa of the movie you are adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_name
    command = "./eac create movie"
    expected = "You must provide the name of the movie you are creating.\nYou must provide the genre and year and length and budget and mpaa of the movie you are adding."
    assert_command_output expected, command
  end

  def test_duplicate_movies_cannot_be_created
    `./eac create movie Anchorman2 --genre 4 --year 2013 --length 100 --budget 20000000 --mpaa R --environment test`
    command = "./eac create movie Anchorman2 --genre 4 --year 2013 --length 100 --budget 20000000 --mpaa R --environment test"
    expected = "A movie titled Anchorman2 has already been created."
    assert_command_output expected, command
  end

end