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

  private

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end
end

