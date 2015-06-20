require_relative 'test_helper'
require './lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :transaction_repository

  def setup
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    @transaction_repository = engine.transaction_repository
  end

  def test_it_has_a_sales_engine
    assert_equal SalesEngine, transaction_repository.sales_engine.class
  end

  def test_it_finds_all_transactions
    output = transaction_repository.all.count
    expected = 10

    assert_equal expected, output
  end

  def test_finds_random_transaction
    assert transaction_repository.respond_to?(:random)
  end

  def test_has_transaction_instances
    output = transaction_repository.transactions[0].class
    expected = Transaction

    assert_equal expected, output
  end

  def test_finds_transactions_by_id
    output = transaction_repository.find_by_id(3).invoice_id
    expected = 4

    assert_equal expected, output
  end

  def test_finds_by_invoice_id
    output = transaction_repository.find_by_invoice_id(4).id
    expected = 3

    assert_equal expected, output
  end

  def test_finds_transactions_by_credit_card_number
    output = transaction_repository.find_by_credit_card_number("4654405418249632")
    expected = 1

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_transactions_by_credit_card_expiration_date
    output = transaction_repository.find_by_credit_card_expiration_date("10/13")
    expected = 1

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_transactions_by_result
    output = transaction_repository.find_by_result("success")
    expected = 1

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_transactions_by_created_at
    output = transaction_repository.find_by_created_at("2012-03-27 14:54:09 UTC")
    expected = 1

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_transactions_by_updated_at
    output = transaction_repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
    expected = 1

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_all_transactions_by_id
    output_1 = transaction_repository.find_all_by_id(1)
    output_2 = transaction_repository.find_all_by_id(11)
    expected_1 = 1
    expected_2 = []

    assert_equal expected_1, output_1[0].invoice_id
    assert_equal expected_2, output_2
  end

  def test_it_finds_all_transactions_by_invoice_id
    output_1 = transaction_repository.find_all_by_invoice_id(1)
    output_2 = transaction_repository.find_all_by_invoice_id(3)
    expected_1 = 1
    expected_2 = []

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  def test_find_all_transactions_by_credit_card_number
    output_1 = transaction_repository.find_all_by_credit_card_number(4801647818676136)
    output_2 = transaction_repository.find_all_by_credit_card_number(1234567890123456)
    expected_1 = 7
    expected_2 = []

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  def test_find_all_transactions_by_credit_card_expiration_date
    output_1 = transaction_repository.find_all_by_credit_card_expiration_date("03/12")
    output_2 = transaction_repository.find_all_by_credit_card_expiration_date("06/16")
    expected_1 = 2
    expected_2 = []

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  def test_find_all_transactions_by_result
    output_1 = transaction_repository.find_all_by_result("success")
    output_2 = transaction_repository.find_all_by_result("fail")
    expected_1 = 1
    expected_2 = []

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  def test_find_all_transactions_by_created_at
    output_1 = transaction_repository.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    output_2 = transaction_repository.find_all_by_created_at("2016-03-27 14:54:09 UTC")
    expected_1 = 1
    expected_2 = []

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  def test_find_all_transactions_by_updated_at
    output_1 = transaction_repository.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    output_2 = transaction_repository.find_all_by_created_at("2016-03-27 14:54:09 UTC")
    expected_1 = 1
    expected_2 = []

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  private

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

end
