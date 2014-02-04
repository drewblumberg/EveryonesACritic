require_relative 'helper'

class TestDeletingReviews < MovieTest
  def test_delete_review
    `./eac create review 'Matrix The' --review 9.5 --environment test`
    command = './eac delete review "Matrix The" --id 1 --environment test'
    expected = 'The movie review for "Matrix The" has been deleted from the database.'
    assert_command_output expected, command
  end

  def test_delete_review_returns_similar
    command = './eac delete review "Matrix" --id 1 --environment test'
    expected = "No movie found.\nDid you mean: \nAnimatrix: Final Flight of the Osiris The, Matrix Reloaded The, Matrix Revolutions The, Matrix The, Sex Files: Sexual Matrix, That 70s Matrix"
    assert_command_output expected, command
  end

  def test_invalid_review_doesnt_get_deleted
    # Current review numbers
    orig_reviews = database.execute "SELECT COUNT(*) FROM reviews"

    command = "./eac delete review 'Matrix The' --environment test"
    expected = "You must provide the review id of the movie review you are trying to delete."
    assert_command_output expected, command

    result = database.execute "SELECT COUNT(*) FROM reviews"
    assert_equal orig_reviews[0][0], result[0][0]
  end
end