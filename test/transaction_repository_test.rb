require_relative 'test_helper'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def test_it_has_a_transaction_repo
    data = ["transaction 1"]
    sales_engine = "engine"
    repo = TransactionRepository.new(data, sales_engine)

    assert repo
  end

  def test_it_finds_all_transactions
    data = ["1", "2", "3", "4", "5", "6", "7"]
    sales_engine = "engine"
    repo = TransactionRepository.new(data, sales_engine)
    expected = ["1", "2", "3", "4", "5", "6", "7"]
    output = repo.all

    assert_equal expected, output
  end

  def test_it_finds_a_random_transaction
    data = ["1", "2", "3", "4", "5", "6", "7"]
    sales_engine = "engine"
    repo = TransactionRepository.new(data, sales_engine)
    output1 = repo.random
    output2 = repo.random

    refute_equal output1, output2
  end

  def test_transaction_repository_holds_transaction_instances
    sales_engine = "Placeholder"
    transaction_repository = "Placeholder"
    input_csv = fixture_path('transaction_fixture.csv')
    data = TransactionParser.new(input_csv, transaction_repository).load_csv
    repo = TransactionRepository.new(data, sales_engine)

    first_transaction = repo.transactions[0]

    assert_equal Transaction, first_transaction.class
  end

  def test_it_finds_transactions_by_id
    sales_engine = "Placeholder"
    transaction_repository = "Placeholder"
    input_csv = fixture_path('transaction_fixture.csv')
    data = TransactionParser.new(input_csv, transaction_repository).load_csv
    repo = TransactionRepository.new(data, sales_engine)
    expected = "1"

    output = repo.find_by_id("1")

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_transactions_by_invoice_id
    sales_engine = "Placeholder"
    transaction_repository = "Placeholder"
    input_csv = fixture_path('transaction_fixture.csv')
    data = TransactionParser.new(input_csv, transaction_repository).load_csv
    repo = TransactionRepository.new(data, sales_engine)
    expected = "1"

    output = repo.find_by_invoice_id("1")

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_transactions_by_credit_card_number
    sales_engine = "Placeholder"
    transaction_repository = "Placeholder"
    input_csv = fixture_path('transaction_fixture.csv')
    data = TransactionParser.new(input_csv, transaction_repository).load_csv
    repo = TransactionRepository.new(data, sales_engine)
    expected = "1"

    output = repo.find_by_credit_card_number("4654405418249632")

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_transactions_by_credit_card_expiration_date
    sales_engine = "Placeholder"
    transaction_repository = "Placeholder"
    input_csv = fixture_path('transaction_fixture.csv')
    data = TransactionParser.new(input_csv, transaction_repository).load_csv
    repo = TransactionRepository.new(data, sales_engine)
    expected = "1"

    output = repo.find_by_credit_card_expiration_date("10/13")

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_transactions_by_result
    sales_engine = "Placeholder"
    transaction_repository = "Placeholder"
    input_csv = fixture_path('transaction_fixture.csv')
    data = TransactionParser.new(input_csv, transaction_repository).load_csv
    repo = TransactionRepository.new(data, sales_engine)
    expected = "1"

    output = repo.find_by_result("success")

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_transactions_by_created_at
    sales_engine = "Placeholder"
    transaction_repository = "Placeholder"
    input_csv = fixture_path('transaction_fixture.csv')
    data = TransactionParser.new(input_csv, transaction_repository).load_csv
    repo = TransactionRepository.new(data, sales_engine)
    expected = "1"

    output = repo.find_by_created_at("2012-03-27 14:54:09 UTC")

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_transactions_by_updated_at
    sales_engine = "Placeholder"
    transaction_repository = "Placeholder"
    input_csv = fixture_path('transaction_fixture.csv')
    data = TransactionParser.new(input_csv, transaction_repository).load_csv
    repo = TransactionRepository.new(data, sales_engine)
    expected = "1"

    output = repo.find_by_updated_at("2012-03-27 14:54:09 UTC")

    assert_equal expected, output.invoice_id
  end

  def test_it_finds_all_transactions_by_id
    sales_engine = "Placeholder"
    transaction_repository = "Placeholder"
    input_csv = fixture_path('transaction_fixture.csv')
    data = TransactionParser.new(input_csv, transaction_repository).load_csv
    repo = TransactionRepository.new(data, sales_engine)
    expected_1 = "1"
    expected_2 = []

    output_1 = repo.find_all_by_id("1")
    output_2 = repo.find_all_by_id("11")

    assert_equal expected_1, output_1[0].invoice_id
    assert_equal expected_2, output_2
  end

  def test_it_finds_all_transactions_by_invoice_id
    sales_engine = "Placeholder"
    transaction_repository = "Placeholder"
    input_csv = fixture_path('transaction_fixture.csv')
    data = TransactionParser.new(input_csv, transaction_repository).load_csv
    repo = TransactionRepository.new(data, sales_engine)
    expected_1 = "1"
    expected_2 = []

    output_1 = repo.find_all_by_invoice_id("1")
    output_2 = repo.find_all_by_invoice_id("3")

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  def test_find_all_transactions_by_credit_card_number
    sales_engine = "Placeholder"
    transaction_repository = "Placeholder"
    input_csv = fixture_path('transaction_fixture.csv')
    data = TransactionParser.new(input_csv, transaction_repository).load_csv
    repo = TransactionRepository.new(data, sales_engine)
    expected_1 = "7"
    expected_2 = []

    output_1 = repo.find_all_by_credit_card_number("4801647818676136")
    output_2 = repo.find_all_by_credit_card_number("1234567890123456")

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  def test_find_all_transactions_by_credit_card_expiration_date
    sales_engine = "Placeholder"
    transaction_repository = "Placeholder"
    input_csv = fixture_path('transaction_fixture.csv')
    data = TransactionParser.new(input_csv, transaction_repository).load_csv
    repo = TransactionRepository.new(data, sales_engine)
    expected_1 = "2"
    expected_2 = []

    output_1 = repo.find_all_by_credit_card_expiration_date("03/12")
    output_2 = repo.find_all_by_credit_card_expiration_date("06/16")

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  def test_find_all_transactions_by_result
    sales_engine = "Placeholder"
    transaction_repository = "Placeholder"
    input_csv = fixture_path('transaction_fixture.csv')
    data = TransactionParser.new(input_csv, transaction_repository).load_csv
    repo = TransactionRepository.new(data, sales_engine)
    expected_1 = "1"
    expected_2 = []

    output_1 = repo.find_all_by_result("success")
    output_2 = repo.find_all_by_result("fail")

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  def test_find_all_transactions_by_created_at
    sales_engine = "Placeholder"
    transaction_repository = "Placeholder"
    input_csv = fixture_path('transaction_fixture.csv')
    data = TransactionParser.new(input_csv, transaction_repository).load_csv
    repo = TransactionRepository.new(data, sales_engine)
    expected_1 = "1"
    expected_2 = []

    output_1 = repo.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    output_2 = repo.find_all_by_created_at("2016-03-27 14:54:09 UTC")

    assert_equal expected_1, output_1[0].id
    assert_equal expected_2, output_2
  end

  def test_find_all_transactions_by_updated_at
    sales_engine = "Placeholder"
    transaction_repository = "Placeholder"
    input_csv = fixture_path('transaction_fixture.csv')
    data = TransactionParser.new(input_csv, transaction_repository).load_csv
    repo = TransactionRepository.new(data, sales_engine)
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
