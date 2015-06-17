require_relative 'test_helper'
require './lib/transaction_parser'

class TransactionParserTest < Minitest::Test

  def test_it_takes_a_csv
    input_csv = fixture_path('transaction_fixture.csv')
    parser = TransactionParser.new(input_csv, "transaction_repo_placeholder")
    assert parser
  end

  def test_it_parses_and_stores_csv_data
    input_csv = fixture_path('transaction_fixture.csv')
    parser = TransactionParser.new(input_csv, "transaction_repo_placeholder")
    output = parser.load_csv

    assert_equal 10, output.count
    assert_equal "1", output[0].invoice_id
    assert_equal "success", output[0].result
  end

  private

  def fixture_path(file_name)
    File.join(fixtures_directory, file_name)
  end

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

end
