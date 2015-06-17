require_relative 'test_helper'
require './lib/merchant_repository'
require './lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test

  attr_reader :merchant_repository

  def setup
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    @merchant_repository = engine.merchant_repository
  end

  def test_it_finds_a_single_merchant
    assert_equal "Schroeder-Jerde", merchant_repository.find_by_id(1).name
  end
  def test_it_finds_merchants_by_id
    result = merchant_repository.find_by_id(1)
    assert_equal "Schroeder-Jerde", result.name
  end

  def test_it_finds_merchants_by_name
    result = merchant_repository.find_by_name("Schroeder-Jerde")
    assert_equal 1, result.id
  end

  def test_it_finds_merchants_by_created_at
    result = merchant_repository.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal "Schroeder-Jerde", result.name
  end

  def test_it_finds_merchants_by_updated_at
    result = merchant_repository.find_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal "Schroeder-Jerde", result.name
  end

  def test_it_finds_merchants_all_by_id
    result1 = merchant_repository.find_all_by_id(1)
    result2 = merchant_repository.find_all_by_id(11)
    assert_equal Array, result1.class
    assert_equal 1, result1.length
    assert_equal 0, result2.length
  end

  def test_it_finds_all_merchants_by_name
    result1 = merchant_repository.find_all_by_name("Williamson Group")
    result2 = merchant_repository.find_all_by_name("Bob")
    assert_equal Array, result1.class
    assert_equal 2, result1.length
    assert_equal 0, result2.length
  end

  def test_find_all_merchants_by_created_at
    result1 = merchant_repository.find_all_by_created_at("2012-03-27 14:53:59 UTC")
    result2 = merchant_repository.find_all_by_created_at("2015-03-27 14:53:59 UTC")

    assert_equal Array, result1.class
    assert_equal 9, result1.length
    assert_equal 0, result2.length
  end

  def test_find_all_merchants_by_updated_at
    result1 = merchant_repository.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
    result2 = merchant_repository.find_all_by_updated_at("2015-03-27 14:53:59 UTC")

    assert_equal Array, result1.class
    assert_equal 8, result1.length
    assert_equal 0, result2.length
  end

  private

  def fixture_path(file_name)
    File.join(fixtures_directory, file_name)
  end

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

end
