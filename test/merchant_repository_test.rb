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

  def test_it_finds_merchants_by_id
    data = ["Ace", "Lowes", "Home Depot"]
    sales_engine = "engine"
    repo = MerchantRepository.new(data, sales_engine)
    expected = ["Ace", "Lowes", "Home Depot"]
    output = repo.all

    assert_equal expected, output
  end

end
