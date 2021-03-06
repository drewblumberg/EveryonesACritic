require_relative 'helper'

class TestSearchingReviews < MovieTest
  def test_search_returns_movie
    `./eac create review 'Matrix The' --review 9.5 --environment production`
    `./eac create review 'Matrix The' --review 9 --environment production`
    command = './eac search review "Matrix The" --environment production'
    expected = "Matrix The: a action film with a review score of 9.5"
    expected2 = "Matrix The: a action film with a review score of 9.0"
    assert_command_output_includes expected, command
    assert_command_output_includes expected2, command
  end

  def test_search_returns_no_reviews
    command = './eac search review "asdfghjasdfghj" --environment test'
    expected = "No movie reviews found with title 'asdfghjasdfghj'. Would you like to create one? Just use the command 'create review'."
    assert_command_output expected, command
  end

  def returns_similar_movie_data
    command = './eac search review "Matrix" --environment production'
    expected = "No movie reviews found with title 'Matrix'. Would you like to create one? Just use the command 'movie review'.\nDid you mean: \nAnimatrix: Final Flight of the Osiris The, Matrix Reloaded The, Matrix Revolutions The, Matrix The, Sex Files: Sexual Matrix, That 70s Matrix"
    assert_command_output expected, command
  end
end