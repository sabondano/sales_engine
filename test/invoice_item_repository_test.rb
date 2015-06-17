require_relative 'test_helper'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_has_an_invoice_item_repo
    data = ["invoice_item 1"]
    sales_engine = "engine"
    repo = InvoiceItemRepository.new(data, sales_engine)

    assert repo
  end

  def test_it_finds_all_invoice_items
    data = ["1", "2", "3", "4", "5", "6", "7"]
    sales_engine = "engine"
    repo = InvoiceItemRepository.new(data, sales_engine)
    expected = ["1", "2", "3", "4", "5", "6", "7"]
    output = repo.all

    assert_equal expected, output
  end

  def test_it_finds_a_random_invoice_item
    data = ["1", "2", "3", "4", "5", "6", "7"]
    sales_engine = "engine"
    repo = InvoiceItemRepository.new(data, sales_engine)
    output1 = repo.random
    output2 = repo.random

    refute_equal output1, output2
  end

  def test_invoice_item_repository_holds_invoice_item_instances
    sales_engine = "Placeholder"
    invoice_item_repository = "Placeholder"
    input_csv = fixture_path('invoice_items_fixture.csv')
    data = InvoiceItemParser.new(input_csv, invoice_item_repository).load_csv
    repo = InvoiceItemRepository.new(data, sales_engine)

    first_invoice_item = repo.invoice_items[0]

    assert_equal InvoiceItem, first_invoice_item.class
  end

  def test_it_finds_invoice_items_by_id
    sales_engine = "Placeholder"
    invoice_item_repository = "Placeholder"
    input_csv = fixture_path('invoice_items_fixture.csv')
    data = InvoiceItemParser.new(input_csv, invoice_item_repository).load_csv
    repo = InvoiceItemRepository.new(data, sales_engine)
    expected = "1"

    output = repo.find_by_id("1")

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_invoice_items_by_item_id
    sales_engine = "Placeholder"
    invoice_item_repository = "Placeholder"
    input_csv = fixture_path('invoice_items_fixture.csv')
    data = InvoiceItemParser.new(input_csv, invoice_item_repository).load_csv
    repo = InvoiceItemRepository.new(data, sales_engine)
    expected = "1"

    output = repo.find_by_item_id("539")

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_invoice_items_by_invoice_id
    sales_engine = "Placeholder"
    invoice_item_repository = "Placeholder"
    input_csv = fixture_path('invoice_items_fixture.csv')
    data = InvoiceItemParser.new(input_csv, invoice_item_repository).load_csv
    repo = InvoiceItemRepository.new(data, sales_engine)
    expected = "539"

    output = repo.find_by_invoice_id("1")

    assert_equal expected, output.item_id
  end

  def test_it_finds_invoice_items_by_quantity
    sales_engine = "Placeholder"
    invoice_item_repository = "Placeholder"
    input_csv = fixture_path('invoice_items_fixture.csv')
    data = InvoiceItemParser.new(input_csv, invoice_item_repository).load_csv
    repo = InvoiceItemRepository.new(data, sales_engine)
    expected = "1"

    output = repo.find_by_quantity("5")

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_invoice_items_by_unit_price
    sales_engine = "Placeholder"
    invoice_item_repository = "Placeholder"
    input_csv = fixture_path('invoice_items_fixture.csv')
    data = InvoiceItemParser.new(input_csv, invoice_item_repository).load_csv
    repo = InvoiceItemRepository.new(data, sales_engine)
    expected = "1"

    output = repo.find_by_unit_price(136.35)

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_invoice_items_by_created_at
    sales_engine = "Placeholder"
    invoice_item_repository = "Placeholder"
    input_csv = fixture_path('invoice_items_fixture.csv')
    data = InvoiceItemParser.new(input_csv, invoice_item_repository).load_csv
    repo = InvoiceItemRepository.new(data, sales_engine)
    expected = "1"

    output = repo.find_by_created_at("2012-03-27 14:54:09 UTC")

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_invoice_items_by_updated_at
    sales_engine = "Placeholder"
    invoice_item_repository = "Placeholder"
    input_csv = fixture_path('invoice_items_fixture.csv')
    data = InvoiceItemParser.new(input_csv, invoice_item_repository).load_csv
    repo = InvoiceItemRepository.new(data, sales_engine)
    expected = "1"

    output = repo.find_by_updated_at("2012-03-27 14:54:09 UTC")

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_all_invoice_items_by_id
    sales_engine = "Placeholder"
    invoice_item_repository = "Placeholder"
    input_csv = fixture_path('invoice_items_fixture.csv')
    data = InvoiceItemParser.new(input_csv, invoice_item_repository).load_csv
    repo = InvoiceItemRepository.new(data, sales_engine)
    expected_1 = "1"
    expected_2 = []

    output_1 = repo.find_all_by_id("1")
    output_2 = repo.find_all_by_id("11")

    assert_equal expected_1, output_1[0].invoice_id
    assert_equal expected_2, output_2
  end

  def test_it_finds_all_invoice_items_by_item_id
    sales_engine = "Placeholder"
    invoice_item_repository = "Placeholder"
    input_csv = fixture_path('invoice_items_fixture.csv')
    data = InvoiceItemParser.new(input_csv, invoice_item_repository).load_csv
    repo = InvoiceItemRepository.new(data, sales_engine)
    expected_1 = "1"
    expected_2 = []

    output_1 = repo.find_all_by_item_id("539")
    output_2 = repo.find_all_by_item_id("400")

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  def test_find_all_invoice_items_by_invoice_id
    sales_engine = "Placeholder"
    invoice_item_repository = "Placeholder"
    input_csv = fixture_path('invoice_items_fixture.csv')
    data = InvoiceItemParser.new(input_csv, invoice_item_repository).load_csv
    repo = InvoiceItemRepository.new(data, sales_engine)
    expected_1 = "1"
    expected_2 = []

    output_1 = repo.find_all_by_invoice_id("1")
    output_2 = repo.find_all_by_invoice_id("7")

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  def test_find_all_invoice_items_by_quantity
    sales_engine = "Placeholder"
    invoice_item_repository = "Placeholder"
    input_csv = fixture_path('invoice_items_fixture.csv')
    data = InvoiceItemParser.new(input_csv, invoice_item_repository).load_csv
    repo = InvoiceItemRepository.new(data, sales_engine)
    expected_1 = "1"
    expected_2 = []

    output_1 = repo.find_all_by_quantity("5")
    output_2 = repo.find_all_by_quantity("16")

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  def test_find_all_invoice_items_by_unit_price
    sales_engine = "Placeholder"
    invoice_item_repository = "Placeholder"
    input_csv = fixture_path('invoice_items_fixture.csv')
    data = InvoiceItemParser.new(input_csv, invoice_item_repository).load_csv
    repo = InvoiceItemRepository.new(data, sales_engine)
    expected_1 = "4"
    expected_2 = []

    output_1 = repo.find_all_by_unit_price(21.96)
    output_2 = repo.find_all_by_unit_price(85.99)

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  def test_find_all_invoice_items_by_created_at
    sales_engine = "Placeholder"
    invoice_item_repository = "Placeholder"
    input_csv = fixture_path('invoice_items_fixture.csv')
    data = InvoiceItemParser.new(input_csv, invoice_item_repository).load_csv
    repo = InvoiceItemRepository.new(data, sales_engine)
    expected_1 = "1"
    expected_2 = []

    output_1 = repo.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    output_2 = repo.find_all_by_created_at("2016-03-27 14:54:09 UTC")

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  def test_find_all_invoice_items_by_updated_at
    sales_engine = "Placeholder"
    invoice_item_repository = "Placeholder"
    input_csv = fixture_path('invoice_items_fixture.csv')
    data = InvoiceItemParser.new(input_csv, invoice_item_repository).load_csv
    repo = InvoiceItemRepository.new(data, sales_engine)
    expected_1 = "1"
    expected_2 = []

    output_1 = repo.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    output_2 = repo.find_all_by_created_at("2016-03-27 14:54:09 UTC")

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  private

  def fixture_path(file_name)
    File.join(fixtures_directory, file_name)
  end

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

end
