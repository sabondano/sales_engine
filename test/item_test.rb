require_relative 'test_helper'
require './lib/item'

class ItemTest < Minitest::Test

  attr_reader :item_repository

  def setup
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    @item_repository = engine.item_repository
  end

  def test_item_has_an_id
    item_data = { id: 1, name: 'Item Qui Esse', description: 'This is the description', unit_price: 75107, merchant_id: 1, created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC' }

    item = Item.new(item_data, 'repository')

    assert_equal 1, item.id
  end

  def test_item_has_a_name
    item_data = { id: 1, name: 'Item Qui Esse', description: 'This is the description', unit_price: 75107, merchant_id: 1, created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC' }

    item = Item.new(item_data, 'repository')

    assert_equal 'Item Qui Esse', item.name
  end

  def test_find_invoice_items_returns_invoice_items_associated_with_item
    result_1 = @item_repository.items[0].invoice_items
    result_2 = @item_repository.items[9].invoice_items

    assert_equal 0, result_1.count
    assert_equal 1, result_2.count
  end

  def test_find_merchant_returns_a_merchant_associated_with_item
    result_1 = @item_repository.items[0].merchant

    assert_equal 'Schroeder-Jerde', result_1.name
  end

  def test_best_day_returns_date_with_the_most_sales_for_given_item_using_the_invoice_date
    load_data
    result_1 = @se.item_repository.items[0].best_day

    assert_equal Date.parse("Jun 30, 2015"), result_1
  end
  private

  def fixtures_directory
    File.expand_path('../../data/fixtures',__FILE__)
  end

  def load_data
    repo_data = {
        items: [
            { id: 1, unit_price: 5_000, created_at: "Jan, 15, 2015", updated_at: "Jan, 15, 2015" },
        ],

        invoices: [
            { id: 10, created_at: "June 1, 2015" },
            { id: 20, created_at: "June 15, 2015" },
            { id: 30, created_at: "June 30, 2015" }
        ],

        invoice_items: [
            { id: 100, item_id: 1, invoice_id: 10, quantity: 1_000, unit_price: 5_000 },
            { id: 200, item_id: 1, invoice_id: 20, quantity: 2_000, unit_price: 55_000 },
            { id: 300, item_id: 1, invoice_id: 30, quantity: 3_000, unit_price: 555_000 }
        ],

        transactions: [
            { id: 7, invoice_id: 10, result: "success"},
            { id: 8, invoice_id: 20, result: "success"},
            { id: 9, invoice_id: 30, result: "success"}
        ]
    }

    @se = SalesEngine.new("fake_path")
    @se.init_repos(repo_data)
  end
end

