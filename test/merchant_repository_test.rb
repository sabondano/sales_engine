require_relative 'test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_has_a_merchant_repo
    data = ["merchant 1"]
    sales_engine = "engine"
    repo = MerchantRepository.new(data, sales_engine)

    assert_equal "engine", repo.sales_engine
  end

  def test_it_finds_all_merchants
    data = ["Ace", "Lowes", "Home Depot"]
    sales_engine = "engine"
    repo = MerchantRepository.new(data, sales_engine)
    expected = ["Ace", "Lowes", "Home Depot"]
    output = repo.all

    assert_equal expected, output
  end

  def test_it_finds_a_random_merchant
    data = ["Ace", "Lowes", "Home Depot", "Target", "another store", "things"]
    sales_engine = "engine"
    repo = MerchantRepository.new(data, sales_engine)
    output1 = repo.random
    output2 = repo.random

    refute_equal output1, output2
  end

  def test_merchant_repository_holds_merchant_instances
    sales_engine = "Placeholder"
    merchant_repository = "Placeholder"
    input_csv = fixture_path('merchants_fixture.csv')
    data = MerchantParser.new(input_csv, merchant_repository).load_csv
    repo = MerchantRepository.new(data, sales_engine)

    first_merchant = repo.merchants[0]

    assert_equal Merchant, first_merchant.class
  end

  def test_it_finds_merchants_by_id
    sales_engine = "Placeholder"
    merchant_repository = "Placeholder"
    input_csv = fixture_path('merchants_fixture.csv')
    data = MerchantParser.new(input_csv, merchant_repository).load_csv
    repo = MerchantRepository.new(data, sales_engine)
    expected = "Schroeder-Jerde"

    output = repo.find_by_id("1")

    assert_equal expected, output.name
  end

  def test_it_finds_merchants_by_name
    sales_engine = "Placeholder"
    merchant_repository = "Placeholder"
    input_csv = fixture_path('merchants_fixture.csv')
    data = MerchantParser.new(input_csv, merchant_repository).load_csv
    repo = MerchantRepository.new(data, sales_engine)
    expected = "Schroeder-Jerde"

    output = repo.find_by_name("Schroeder-Jerde")

    assert_equal expected, output.name
  end

  def test_it_finds_merchants_by_created_at
    sales_engine = "Placeholder"
    merchant_repository = "Placeholder"
    input_csv = fixture_path('merchants_fixture.csv')
    data = MerchantParser.new(input_csv, merchant_repository).load_csv
    repo = MerchantRepository.new(data, sales_engine)
    expected = "Schroeder-Jerde"

    output = repo.find_by_created_at("2012-03-27 14:53:59 UTC")

    assert_equal expected, output.name
  end

  def test_it_finds_merchants_by_updated_at
    sales_engine = "Placeholder"
    merchant_repository = "Placeholder"
    input_csv = fixture_path('merchants_fixture.csv')
    data = MerchantParser.new(input_csv, merchant_repository).load_csv
    repo = MerchantRepository.new(data, sales_engine)
    expected = "Schroeder-Jerde"

    output = repo.find_by_updated_at("2012-03-27 14:53:59 UTC")

    assert_equal expected, output.name
  end

  private

  def fixture_path(file_name)
    File.join(fixtures_directory, file_name)
  end

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

end
