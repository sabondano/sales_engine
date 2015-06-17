require_relative 'test_helper'
require './lib/invoice_item_parser'

class InvoiceItemParserTest < Minitest::Test

  def test_it_takes_a_csv
    input_csv = fixture_path('invoice_items_fixture.csv')
    parser = InvoiceItemParser.new(input_csv, "invoice_item_repo_placeholder")
    assert parser
  end

  def test_it_parses_and_stores_csv_data
    input_csv = fixture_path('invoice_items_fixture.csv')
    parser = InvoiceItemParser.new(input_csv, "invoice_item_repo_placeholder")
    output = parser.load_csv

    assert_equal 10, output.count
    assert_equal 1, output[0].invoice_id
    assert_equal 136.35, output[0].unit_price
  end

  private

  def fixture_path(file_name)
    File.join(fixtures_directory, file_name)
  end

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

end
