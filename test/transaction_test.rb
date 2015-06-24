require_relative 'test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test
  attr_reader :transaction_repository

  def setup
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    @transaction_repository = engine.transaction_repository
  end

  def test_transacton_has_an_id
    data = { id: "1", invoice_id: "1", credit_card_number: "4654405418249632", credit_card_expiration_date: "10/13", result: "success", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC" }
    repository = "transaction repo"

    transaction = Transaction.new(data, repository)

    assert_equal 1, transaction.id
  end

  def test_transaction_has_an_invoice_id
    data = { id: "1", invoice_id: "1", credit_card_number: "4654405418249632", credit_card_expiration_date: "10/13", result: "success", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC" }
    repository = "transaction repo"

    transaction = Transaction.new(data, repository)

    assert_equal 1, transaction.invoice_id
  end

  def test_transaction_has_a_result
    data = { id: "1", invoice_id: "1", credit_card_number: "4654405418249632", credit_card_expiration_date: "10/13", result: "success", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC" }
    repository = "transaction repo"

    transaction = Transaction.new(data, repository)

    assert_equal "success", transaction.result
  end

  def test_find_invoice_returns_an_invoice_for_associated_transaction
    result = @transaction_repository.transactions[9].invoice
    assert_equal 1, result.customer_id
  end

  private

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

end
