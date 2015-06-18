require_relative 'test_helper'
require './lib/invoice_repository'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :invoice_repository

  def setup
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    @invoice_repository = engine.invoice_repository
  end

  def test_it_find_all_invoices
    assert_equal 10, invoice_repository.all.count
  end

  def test_it_has_a_random_method
    assert invoice_repository.respond_to?(:random)
  end

  def test_finds_invoice_by_id
    result = invoice_repository.find_by_id(1)
    assert_equal 1, result.id
  end

  def test_finds_by_customer_id
    result = invoice_repository.find_by_customer_id(2)
    assert_equal 27, result.merchant_id
  end

  def test_finds_by_merchant_id
    result = invoice_repository.find_by_merchant_id(86)
    assert_equal 10, result.id
  end

  def test_it_finds_by_status
    result = invoice_repository.find_by_status("shipped")
    assert_equal 1, result.id
  end

  def test_finds_by_created_at
    result = invoice_repository.find_by_created_at(DateTime.parse('2012-03-25 09:54:09 UTC'))
    assert_equal 1, result.id
  end

  def test_finds_by_updated_at
    result = invoice_repository.find_by_updated_at(DateTime.parse('2012-03-25 09:54:09 UTC'))
    assert_equal 1, result.id
  end

  def test_finds_all_invoices_by_id
    result1 = invoice_repository.find_all_by_id(1)
    result2 = invoice_repository.find_all_by_id(11)
    assert_equal Array, result1.class
    assert_equal 1, result1.length
    assert_equal 0, result2.length
  end

  def test_finds_all_by_customer_id
    result1 = invoice_repository.find_all_by_customer_id(1)
    result2 = invoice_repository.find_all_by_customer_id(11)
    assert_equal Array, result1.class
    assert_equal 8, result1.length
    assert_equal 0, result2.length
  end

  def test_finds_all_by_merchant_id
    result1 = invoice_repository.find_all_by_merchant_id(26)
    result2 = invoice_repository.find_all_by_merchant_id(11)
    assert_equal Array, result1.class
    assert_equal 1, result1.length
    assert_equal 0, result2.length
  end

  def test_it_finds_all_by_status
    result1 = invoice_repository.find_all_by_status("shipped")
    result2 = invoice_repository.find_all_by_status("pending")
    assert_equal Array, result1.class
    assert_equal 10, result1.length
    assert_equal 0, result2.length
  end

  def test_finds_all_by_created_at
    result1 = invoice_repository.find_all_by_created_at(DateTime.parse('2012-03-25 09:54:09 UTC'))
    result2 = invoice_repository.find_all_by_created_at(DateTime.parse('2015-03-25 09:54:09 UTC'))
    assert_equal Array, result1.class
    assert_equal 1, result1.length
    assert_equal 0, result2.length
  end

  def test_finds_all_by_updated_at
    result1 = invoice_repository.find_all_by_updated_at(DateTime.parse('2012-03-25 09:54:09 UTC'))
    result2 = invoice_repository.find_all_by_updated_at(DateTime.parse('2015-03-25 09:54:09 UTC'))
    assert_equal Array, result1.class
    assert_equal 1, result1.length
    assert_equal 0, result2.length
  end

  private

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end
end
