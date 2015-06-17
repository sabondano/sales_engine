require_relative 'test_helper'
require './lib/invoice_parser'

class InvoiceParserTest < Minitest::Test

  def test_it_takes_two_arguments
    input_csv = fixture_path('invoices_fixture.csv')
    parser = InvoiceParser.new(input_csv, "invoice repo placeholder")

    assert parser
  end

  def test_it_parses_csv_data
    input_csv = fixture_path('invoices_fixture.csv')
    parser = InvoiceParser.new(input_csv, "invoice repo placeholder")

    output = parser.load_csv

    assert_equal 10, output.count
    assert_equal 26, output[0].merchant_id
  end

  private

  def fixture_path(file_name)
    File.join(fixtures_directory, file_name)
  end

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

end