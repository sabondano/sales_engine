require_relative 'test_helper'
require './lib/customer_parser'

class CustomerParserTest < Minitest::Test

  def test_it_takes_a_csv
    input_csv = fixture_path('customers_fixture.csv')
    parser = CustomerParser.new(input_csv, "customer_repo_placeholder")
    assert parser
  end

  def test_it_parses_and_stores_csv_data
    input_csv = fixture_path('customers_fixture.csv')
    parser = CustomerParser.new(input_csv, "customer_repo_placeholder")
    output = parser.load_csv

    assert_equal 10, output.count
    assert_equal "Joey", output[0].first_name
  end

  private

  def fixture_path(file_name)
    File.join(fixtures_directory, file_name)
  end

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

end
