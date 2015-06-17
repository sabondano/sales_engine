require_relative 'test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test
  def transacton_has_an_id
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

end
