require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_starts_up
    engine = SalesEngine.new(fixtures_directory)
    assert engine.startup
  end

  def test_it_can_access_merchant_repository
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    output = engine.merchant_repository.merchants[0].name
    expected = "Schroeder-Jerde"

    assert_equal expected, output
  end

  def test_it_can_access_customer_repository
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    output = engine.customer_repository.customers[0].first_name
    expected = "Joey"

    assert_equal expected, output
  end

  def test_it_can_access_transaction_repository
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    output = engine.transaction_repository.transactions[0].id
    expected = 1

    assert_equal expected, output
  end

  def test_it_can_access_invoice_item_repository
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    output = engine.invoice_item_repository.invoice_items[0].item_id
    expected = 539

    assert_equal expected, output
  end

  def test_it_can_access_invoice_repository
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    output = engine.invoice_repository.invoices[0].merchant_id
    expected = 26

    assert_equal expected, output
  end

  def test_it_can_access_item_repository
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    output = engine.item_repository.items[0].name
    expected = "Item Qui Esse"

    assert_equal expected, output
  end

  private

  def fixture_path(file_name)
    File.join(fixtures_directory, file_name)
  end

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

end
