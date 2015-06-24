require_relative 'test_helper'
require './lib/customer_repository'
require './lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test

  attr_reader :customer_repository

  def setup
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    @customer_repository = engine.customer_repository
  end

  def test_inspect_returns_a_string_with_class_and_rows
    result = customer_repository.inspect
    expected = "CustomerRepository 10 rows"
    assert_equal expected, result
  end

  def test_it_find_all_customers
    assert_equal 10, customer_repository.all.count
  end

  def test_it_has_a_random_method
    customers = []
    10.times { customers << customer_repository.random }
    refute customers.uniq.length == 1
  end

  def test_it_finds_customers_by_id
    result = customer_repository.find_by_id(1)
    assert_equal "Joey", result.first_name
  end

  def test_it_finds_customer_by_first_name
    result1 = customer_repository.find_by_first_name("Joey")
    result2 = customer_repository.find_by_first_name("joey")
    assert_equal 1, result1.id
    assert_equal 1, result2.id
  end

  def test_it_finds_customer_by_last_name
    result1 = customer_repository.find_by_last_name("Reynolds")
    result2 = customer_repository.find_by_last_name("reynolds")
    assert_equal "Ramona", result1.first_name
    assert_equal "Ramona", result2.first_name
  end

  def test_it_finds_customer_by_created_at
    result = customer_repository.find_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal "Cecelia", result.first_name
  end

  def test_it_finds_customer_by_updated_at
    result = customer_repository.find_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal "Cecelia", result.first_name
  end

  def test_it_finds_all_customers_by_id
    result1 = customer_repository.find_all_by_id(1)
    result2 = customer_repository.find_all_by_id(11)
    assert_equal Array, result1.class
    assert_equal 1, result1.length
    assert_equal 0, result2.length
  end

  def test_it_finds_all_customers_by_first_name
    result1 = customer_repository.find_all_by_first_name("joey")
    result2 = customer_repository.find_all_by_first_name("Sebastian")
    result3 = customer_repository.find_all_by_first_name("Joey")
    assert_equal Array, result1.class
    assert_equal 1, result1.length
    assert_equal 0, result2.length
    assert_equal 1, result3.length
  end

  def test_it_finds_all_customers_by_last_name
    result1 = customer_repository.find_all_by_last_name("Osinski")
    result2 = customer_repository.find_all_by_last_name("Abondano")
    result3 = customer_repository.find_all_by_last_name("osinski")
    assert_equal Array, result1.class
    assert_equal 1, result1.length
    assert_equal 0, result2.length
    assert_equal 1, result3.length
  end

  def test_it_finds_all_customers_by_created_at
    result1 = customer_repository.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    result2 = customer_repository.find_all_by_created_at("2015-03-27 14:54:09 UTC")
    assert_equal Array, result1.class
    assert_equal 1, result1.length
    assert_equal 0, result2.length
  end

  def test_it_finds_all_customers_by_updated_at
    result1 = customer_repository.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    result2 = customer_repository.find_all_by_updated_at("2015-03-27 14:54:09 UTC")
    assert_equal Array, result1.class
    assert_equal 1, result1.length
    assert_equal 0, result2.length
  end

  private

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end
end
