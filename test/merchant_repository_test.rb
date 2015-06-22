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

  def test_most_revenue_returns_top_x_merchant_instances_ranked_by_total_revenue
    load_data
    result_1 = @se.merchant_repository.most_revenue(1)[0].id
    result_2 = @se.merchant_repository.most_revenue(3).count
    result_3 = @se.merchant_repository.most_revenue(2).last.id
    assert_equal 20, result_1
    assert_equal  3, result_2
    assert_equal 30, result_3
  end
  
  def test_most_items_returns_top_x_merchants_ranked_by_total_items_sold
    load_data
    result_1 = @se.merchant_repository.most_items(1)[0].id
    result_2 = @se.merchant_repository.most_items(3).count
    result_3 = @se.merchant_repository.most_items(3)[0].id
    assert_equal 20, result_1
    assert_equal 3, result_2
    assert_equal 20, result_3
  end

  private

  def fixture_path(file_name)
    File.join(fixtures_directory, file_name)
  end

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

  def load_data
    repo_data = {
      merchants: [
        {id: 10, name: "merchant_1"},
        {id: 20, name: "merchant_2"},
        {id: 30, name: "merchant_3"}
      ],

      invoices: [
        {id: 1, merchant_id: 10},
        {id: 2, merchant_id: 20},
        {id: 3, merchant_id: 30}
      ],

      invoice_items: [
        {id: 100, invoice_id: 1, quantity:  5,  unit_price: 10_000},
        {id: 200, invoice_id: 2, quantity: 10,  unit_price: 20_000},
        {id: 300, invoice_id: 3, quantity:  5,  unit_price: 30_000}
      ],

      transactions: [
        {id: 7, invoice_id: 1, result: "success"},
        {id: 8, invoice_id: 2, result: "success"},
        {id: 9, invoice_id: 3, result: "success"},
      ]
    }

    @se = SalesEngine.new("fake_path")
    @se.init_repos(repo_data)
  end
end