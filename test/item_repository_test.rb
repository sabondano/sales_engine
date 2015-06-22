require_relative 'test_helper'
require './lib/sales_engine'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository

  def setup
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    @item_repository = engine.item_repository
  end

  def test_it_has_a_sales_engine
    assert_equal SalesEngine, item_repository.sales_engine.class
  end

  def test_fnds_all_items
    output = item_repository.all.count
    expected = 10

    assert_equal expected, output
  end

  def test_it_has_a_random_method
    assert item_repository.respond_to?(:random)
  end

  def test_find_by_id
    output = item_repository.find_by_id(3).name
    expected = 'Item Ea Voluptatum'

    assert_equal expected, output
  end

  def test_find_by_name
    output_1 = item_repository.find_by_name('Item Ea Voluptatum').id
    expected_1 = 3
    output_2 = item_repository.find_by_name('item ea voluptatum').id
    expected_2 = 3

    assert_equal expected_1, output_1
    assert_equal expected_2, output_2
  end

  def test_find_by_description
    output_1 = item_repository.find_by_description('Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.').id
    expected_1 = 1
    output_2 = item_repository.find_by_description('nihil autem sit odio inventore deleniti. est laudantium ratione distinctio laborum. minus voluptatem nesciunt assumenda dicta voluptatum porro.').id
    expected_2 = 1

    assert_equal expected_1, output_1
    assert_equal expected_2, output_2
  end

  def test_find_by_unit_price
    output = item_repository.find_by_unit_price(159.25).id
    expected = 6

    assert_equal expected, output
  end

  def test_find_by_merchant_id
    output = item_repository.find_by_merchant_id(1).id
    expected = 1

    assert_equal expected, output
  end

  def test_find_by_created_at
    output = item_repository.find_by_created_at(Date.parse('2012-03-27 14:53:59 UTC')).id
    expected = 1

    assert_equal expected, output
  end

  def test_find_by_updated_at
    output = item_repository.find_by_updated_at(Date.parse('2012-03-27 14:53:59 UTC')).id
    expected = 1

    assert_equal expected, output
  end

  def test_find_all_by_id
    output_1= item_repository.find_all_by_id(3).count
    expected_1 = 1
    output_2= item_repository.find_all_by_id(89)
    expected_2 = []

    assert_equal expected_1, output_1
    assert_equal expected_2, output_2
  end

  def test_find_all_by_name
    output_1 = item_repository.find_all_by_name('Item Ea Voluptatum').count
    expected_1 = 1
    output_2 = item_repository.find_all_by_name('item ea voluptatum').count
    expected_2 = 1
    output_3 = item_repository.find_all_by_name('reebooks')
    expected_3 = []

    assert_equal expected_1, output_1
    assert_equal expected_2, output_2
    assert_equal expected_3, output_3
  end

  def test_find_all_by_description
    output_1 = item_repository.find_all_by_description('Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.').count
    expected_1 = 1
    output_2 = item_repository.find_all_by_description('nihil autem sit odio inventore deleniti. est laudantium ratione distinctio laborum. minus voluptatem nesciunt assumenda dicta voluptatum porro.').count
    expected_2 = 1
    output_3 = item_repository.find_all_by_description('long sleeve tshirt')
    expected_3 = []

    assert_equal expected_1, output_1
    assert_equal expected_2, output_2
    assert_equal expected_3, output_3
  end

  def test_find_all_by_unit_price
    output_1 = item_repository.find_all_by_unit_price(159.25).count
    expected_1 = 1
    output_2 = item_repository.find_all_by_unit_price(1.00)
    expected_2 = []

    assert_equal expected_1, output_1
    assert_equal expected_2, output_2
  end

  def test_find_all_by_merchant_id
    output_1 = item_repository.find_all_by_merchant_id(1).count
    expected_1 = 10
    output_2 = item_repository.find_all_by_merchant_id(11)
    expected_2 = []

    assert_equal expected_1, output_1
    assert_equal expected_2, output_2
  end

  def test_find_all_by_created_at
    output_1 = item_repository.find_all_by_created_at(Date.parse('2012-03-27 14:53:59 UTC')).count
    expected_1 = 10
    output_2 = item_repository.find_all_by_created_at(Date.parse('2015-03-27 14:53:59 UTC'))
    expected_2 = []

    assert_equal expected_1, output_1
    assert_equal expected_2, output_2
  end

  def test_find_all_by_updated_at
    output_1 = item_repository.find_all_by_updated_at(Date.parse('2012-03-27 14:53:59 UTC')).count
    expected_1 = 10
    output_2 = item_repository.find_all_by_updated_at(Date.parse('2015-03-27 14:53:59 UTC'))
    expected_2 = []

    assert_equal expected_1, output_1
    assert_equal expected_2, output_2
  end

  def test_most_revenue_returns_top_x_item_instances_ranked_by_total_revenue
    load_data
    result_1 = @se.item_repository.most_revenue(1)[0].id
    result_2 = @se.item_repository.most_revenue(2).count
    assert_equal 63, result_1
    assert_equal 2, result_2
  end

  def test_most_items_returns__top_x_item_instances_ranked_by_total_number_sold
    load_data
    result_1 = @se.item_repository.most_items(1)[0].id
    assert_equal 63, result_1
  end

  private

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

  def load_data
    repo_data = {
      items: [
        { id: 61, merchant_id: 10, unit_price: 10_000, created_at: "2012-03-24", updated_at: "2012-03-24" },
        { id: 63, merchant_id: 20, unit_price: 20_000, created_at: "2012-03-24", updated_at: "2012-03-24" },
        { id: 65, merchant_id: 30, unit_price: 30_000, created_at: "2012-03-24", updated_at: "2012-03-24" }
      ],

      merchants: [
          { id: 10, name: "merchant_1" },
          { id: 20, name: "merchant_2" },
          { id: 30, name: "merchant_3" }
      ],

      invoices: [
        { id: 1, merchant_id: 10, created_at: "2012-03-24" },
        { id: 2, merchant_id: 20, created_at: "2012-03-25" },
        { id: 3, merchant_id: 30, created_at: "2012-03-24" }
      ],

      invoice_items: [
        { id: 100, invoice_id: 1, item_id: 61, quantity:  5,  unit_price: 10_000 },
        { id: 200, invoice_id: 2, item_id: 63, quantity: 10,  unit_price: 20_000 },
        { id: 300, invoice_id: 3, item_id: 65, quantity:  5,  unit_price: 30_000 }
      ],

      transactions: [
        { id: 6, invoice_id: 1, result: "success" },
        { id: 7, invoice_id: 2, result: "success" },
        { id: 8, invoice_id: 3, result: "success" },
        { id: 9, invoice_id: 3, result: "failed"  }
      ]
      }

    @se = SalesEngine.new("fake_path")
    @se.init_repos(repo_data)
  end
end