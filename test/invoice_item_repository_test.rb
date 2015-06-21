require_relative 'test_helper'
require './lib/invoice_item_repository'
require './lib/sales_engine'

class InvoiceItemRepositoryTest < Minitest::Test

  attr_reader :invoice_item_repository

  def setup
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    @invoice_item_repository = engine.invoice_item_repository
  end

  def test_it_find_all_invoice_items
    assert_equal 10, invoice_item_repository.all.count
  end

  def test_it_finds_a_single_invoice_item
    assert_equal 539, invoice_item_repository.find_by_id(1).item_id
  end

  def test_it_finds_invoice_items_by_id
    result = invoice_item_repository.find_by_id(1)
    assert_equal 539, result.item_id
  end

  def test_it_finds_invoice_items_by_item_id
    result = invoice_item_repository.find_by_item_id(539)
    assert_equal 1, result.id
  end

  def test_it_finds_invoice_items_by_invoice_id
    result = invoice_item_repository.find_by_item_id(539)
    assert_equal 1, result.id
  end

  def test_it_finds_invoice_items_by_quantity
    result = invoice_item_repository.find_by_quantity(5)
    assert_equal 1, result.id
  end

  def test_it_finds_invoice_items_by_unit_price
    result = invoice_item_repository.find_by_unit_price(136.35)
    assert_equal 1, result.id
  end

  def test_it_finds_invoice_items_by_created_at
    result = invoice_item_repository.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, result.id
  end

  def test_it_finds_invoice_items_by_updated_at
    result = invoice_item_repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, result.id
  end

  def test_it_finds_all_invoice_items_by_id
    result1 = invoice_item_repository.find_all_by_id(1)
    result2 = invoice_item_repository.find_all_by_id(11)
    assert_equal Array, result1.class
    assert_equal 1, result1.length
    assert_equal 0, result2.length
  end

  def test_it_finds_all_invoice_items_by_item_id
    result1 = invoice_item_repository.find_all_by_item_id(539)
    result2 = invoice_item_repository.find_all_by_item_id(540)
    assert_equal Array, result1.class
    assert_equal 1, result1.length
    assert_equal 0, result2.length
  end

  def test_find_all_invoice_items_by_invoice_id
    result1 = invoice_item_repository.find_all_by_invoice_id(1)
    result2 = invoice_item_repository.find_all_by_invoice_id(7)
    assert_equal Array, result1.class
    assert_equal 7, result1.length
    assert_equal 0, result2.length
  end

  def test_find_all_invoice_items_by_quantity
    result1 = invoice_item_repository.find_all_by_quantity(5)
    result2 = invoice_item_repository.find_all_by_quantity(8657)
    assert_equal Array, result1.class
    assert_equal 2, result1.length
    assert_equal 0, result2.length
  end

  def test_find_all_invoice_items_by_unit_price
    result1 = invoice_item_repository.find_all_by_unit_price(21.96)
    result2 = invoice_item_repository.find_all_by_unit_price(86.57)
    assert_equal Array, result1.class
    assert_equal 1, result1.length
    assert_equal 0, result2.length
  end

  def test_find_all_invoice_items_by_created_at
    result1 = invoice_item_repository.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    result2 = invoice_item_repository.find_all_by_created_at("2016-03-27 14:54:09 UTC")
    assert_equal Array, result1.class
    assert_equal 10, result1.length
    assert_equal 0, result2.length
  end

  def test_find_all_invoice_items_by_updated_at
    result1 = invoice_item_repository.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    result2 = invoice_item_repository.find_all_by_updated_at("2016-03-27 14:54:09 UTC")
    assert_equal Array, result1.class
    assert_equal 10, result1.length
    assert_equal 0, result2.length
  end

  private

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

end
