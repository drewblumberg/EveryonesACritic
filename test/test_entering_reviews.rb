require_relative 'helper'
require_relative '../lib/environment'

class TestEnteringReviews < MovieTest
  def test_valid_review_information_gets_printed
    `./eac create movie Anchorman2 --genre "comedy" --year 2013 --length 100 --budget 20000000 --mpaa R --environment test`
    command = "./eac create review 'Anchorman2' --review 9.5 --environment test"
    expected = "A movie review of 9.5 for Anchorman2 was created."
    assert_command_output expected, command
  end

  def test_valid_review_gets_saved
    skip
    # Current review numbers
    orig_reviews = Review.count

    `./eac create review 'Matrix The' --review 9.5 --environment test`
    results = database.execute "SELECT reviews.movieID, reviews.review, movies.title FROM reviews INNER JOIN movies ON reviews.movieID = CAST(movies.movieID AS INTEGER) WHERE CAST(movies.title AS VARCHAR)='Matrix The'"
    expected = {"movieID"=>32710, "review"=>9.5, "title"=>"Matrix The", 0=>32710, 1=>9.5, 2=>"Matrix The"}
    assert_equal expected, results[0]

    result = Review.count
    assert_equal (orig_reviews + 1), result
  end

  def test_invalid_movie_doesnt_get_saved
    skip
    # Current movie numbers
    orig_reviews = Review.count

    command = "./eac create review 'Matrix The'"
    expected = "You must provide the review score of the movie you are reviewing."
    assert_command_output expected, command

    result = Review.count
    assert_equal orig_reviews, result
  end
end