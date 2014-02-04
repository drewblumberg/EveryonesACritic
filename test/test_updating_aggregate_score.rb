require_relative 'helper'
require_relative '../lib/environment'

class TestUpdatingReviewScore < MovieTest
  def test_review_score_is_true_average
    `./eac create movie Anchorman2 --genre "comedy" --year 2013 --length 100 --budget 20000000 --mpaa R --environment test`
    `./eac create review 'Anchorman2' --review 9.5 --environment test`
    movie = Movie.find('Anchorman2')
    assert_equal movie.aggregateRating, 9.5
    assert_equal movie.totalReviews, 1
    `./eac create review 'Anchorman2' --review 9.0 --environment test`
    movie = Movie.find("Anchorman2")
    assert_equal movie.aggregateRating, 9.25
    assert_equal movie.totalReviews, 2
  end
end