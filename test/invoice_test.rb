require_relative 'test_helper'
require './lib/invoice'

class InvoiceTest < Minitest::Test

  attr_reader :invoice_repository

  def setup
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    @invoice_repository = engine.invoice_repository
  end

  def test_invoice_has_an_id
    data = { id: "1", customer_id: "1", merchant_id: "Ondricka", status: "shipped", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:59 UTC" }
    repository = "merchant repo"

    invoice = Invoice.new(data, repository)

    assert_equal 1, invoice.id
  end

  def test_invoice_has_status
    data = { id: "1", customer_id: "1", merchant_id: "Ondricka", status: "shipped", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:59 UTC" }
    repository = "merchant repo"

    invoice = Invoice.new(data, repository)

    assert_equal "shipped", invoice.status
  end

  def test_find_transactions_returns_transactions_associated_with_invoice
    result = @invoice_repository.invoices[0].transactions

    assert_equal 1, result.count
  end

  private

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end
end