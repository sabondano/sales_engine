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

  def test_find_invoice_items_returns_invoice_items_associated_with_invoice
    result = @invoice_repository.invoices[0].invoice_items

    assert_equal 7, result.count
  end

  def test_find_customer_returns_customer_associated_with_invoice
    result = @invoice_repository.invoices[0].customer

    assert_equal "Joey", result.first_name
  end

  def test_find_merchant_returns_merchant_associated_with_invoice
    result = @invoice_repository.invoices[3].merchant

    assert_equal "Bechtelar, Jones and Stokes", result.name
  end

  def test_find_items_returns_items_associated_with_invoice
    result = @invoice_repository.invoices[0].items

    assert_equal 7, result.count
  end

  def test_charge_creates_new_transaction
    load_data
    invoice = @se.invoice_repository.invoices[0]
    prior_transaction_count = invoice.transactions.count
    invoice.charge(credit_card_number: '1111222233334444',  credit_card_expiration_date: "10/14", result: "success")

    assert_equal prior_transaction_count.next, invoice.transactions.count
  end

  private

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

  def load_data
    repo_data = {
        invoices: [
          {id: 1, created_at: "Jun 5, 2015"}
        ]
    }
    @se = SalesEngine.new("fake_path")
    @se.init_repos(repo_data)
  end
end
