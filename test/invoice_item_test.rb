require_relative 'test_helper'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  attr_reader :invoice_item_repository

  def setup
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    @invoice_item_repository = engine.invoice_item_repository
  end

  def invoice_item_has_an_id
    data = { id: "1", item_id: "539", invoice_id: "1", quantity: "5", unit_price: "13635", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC" }
    repository = "invoice_item repo"

    invoice_item = InvoiceItem.new(data, repository)

    assert_equal 1, invoice_item.id
  end

  def test_invoice_item_has_a_quantity
    data = { id: "1", item_id: "539", invoice_id: "1", quantity: "5", unit_price: "13635", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC" }
    repository = "invoice_item repo"

    invoice_item = InvoiceItem.new(data, repository)

    assert_equal 5, invoice_item.quantity
  end

  def test_invoice_item_has_a_unit_price
    data = { id: "1", item_id: "539", invoice_id: "1", quantity: "5", unit_price: "13635", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC" }
    repository = "invoice_item repo"

    invoice_item = InvoiceItem.new(data, repository)
    assert_equal 136.35, invoice_item.unit_price
  end

  def test_find_invoice_returns_an_invoice_associated_with_invoice_item
    result = @invoice_item_repository.invoice_items[9].invoice
    assert_equal 3, result.customer_id
  end

  private

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

end
