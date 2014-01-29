require 'minitest/autorun'
require_relative '../lib/environment'


class MovieTest < MiniTest::Unit::TestCase
  def assert_command_output expected, command
    actual = `#{command}`.strip
    assert_equal expected, actual
  end

  def assert_command_output_includes expected, command
    actual = `#{command}`.strip
    assert_includes actual, expected
  end

  def database
    Environment.environment = "test"
    Environment.database_connection
  end

  def teardown
    # Delete movie from db
    result = database.execute "SELECT * FROM movies WHERE CAST(title AS varchar) = 'Anchorman2'"
    database.execute "DELETE FROM movies WHERE CAST(title AS varchar) = 'Anchorman2'" if result.length > 0
  end

  def assert_in_output output, *args
    missing_content = []
    args.each do |argument|
      unless output.include?(argument)
        missing_content << argument
      end
    end
    assert missing_content.empty?, "Output didn't include #{missing_content.join(", ")}:\n #{output}"
  end

  def assert_not_in_output output, *args
    args.each do |argument|
      assert !output.include?(argument), "Output shouldn't include #{argument}: #{output}"
    end
  end
end